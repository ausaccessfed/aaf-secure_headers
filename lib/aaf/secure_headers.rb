require 'aaf/secure_headers/version'
require 'aaf/secure_headers/disable_secure_headers_for_error_pages'
require 'secure_headers'
require 'active_support/core_ext/integer/time'

module AAF
  module SecureHeaders
    ::SecureHeaders::Configuration.default do |config|
      config.cookies = {
        secure: true,
        httponly: true,
        samesite: {
          lax: false
        }
      }

      config.hsts = "max-age=#{6.months.to_i}; includeSubdomains; preload"
      config.x_frame_options = 'DENY'
      config.x_content_type_options = 'nosniff'
      config.x_xss_protection = '1; mode=block'
      config.x_download_options = 'noopen'
      config.x_permitted_cross_domain_policies = 'none'
      config.referrer_policy = 'strict-same-origin'

      config.csp = {
        preserve_schemes: false,
        block_all_mixed_content: true,
        upgrade_insecure_requests: true,

        default_src: ["'none'"],
        base_uri: ["'none'"],
        font_src: ["'self'", 'https://fonts.gstatic.com'],
        form_action: ["'self'"],
        frame_ancestors: ["'none'"],
        img_src: ["'self'", 'data:'],
        script_src: ["'self'"],
        style_src: ["'self'", 'https://fonts.googleapis.com'],
        report_uri: []
      }
    end

    class <<self
      def development_mode!
        ensure_rails
        insert_dev_middleware
        override_dev_configuration
      end

      private

      def ensure_rails
        return if const_defined?('Rails')

        raise 'The Rails class is not defined. The `development_mode!` helper '\
              'can only be used in a Rails application.'
      end

      def insert_dev_middleware
        Rails.application.config.middleware.insert_after(
          ::SecureHeaders::Middleware,
          AAF::SecureHeaders::DisableSecureHeadersForErrorPages
        )
      end

      def override_dev_configuration
        ::SecureHeaders::Configuration.override(:default) do |config|
          config.hsts = nil
          config.csp[:upgrade_insecure_requests] = false
        end
      end
    end
  end
end
