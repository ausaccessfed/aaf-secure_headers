# frozen_string_literal: true

module AAF
  module SecureHeaders
    class DisableSecureHeadersForErrorPages
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env).tap do |(status, _, _)|
          next if status < 400
          request = ActionDispatch::Request.new(env)
          ::SecureHeaders.opt_out_of_all_protection(request)
        end
      end
    end
  end
end
