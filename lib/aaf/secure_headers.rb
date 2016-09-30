require "aaf/secure_headers/version"
require 'secure_headers'

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
      config.referrer_policy = 'origin-when-cross-origin'

      config.csp = {
        preserve_schemes: false,
        block_all_mixed_content: true,
        upgrade_insecure_requests: true,

        default_src: ["'none'"],
        base_uri: ["'none'"],
        font_src: ["'self'", 'data:', 'https://fonts.gstatic.com'],
        form_action: ["'self'"],
        frame_ancestors: ["'none'"],
        img_src: ["'self'", 'data:'],
        object_src: ["'self'"],
        script_src: ["'self'"],
        style_src: ["'self'", 'https://fonts.googleapis.com'],
        report_uri: []
      }
    end
  end
end
