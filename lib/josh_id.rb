require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class JoshId < OmniAuth::Strategies::OAuth2

      CUSTOM_PROVIDER_URL = 'http://localhost:3000'

      option :client_options, {
        :site =>  CUSTOM_PROVIDER_URL,
        :authorize_url => "#{CUSTOM_PROVIDER_URL}/auth/josh_id/authorize",
        :access_token_url => "#{CUSTOM_PROVIDER_URL}/auth/josh_id/access_token"
      }

      uid { raw_info['id'] }

      info do
        {
          :email => raw_info['email']
        }
      end

      extra do
        {
          :first_name => raw_info['extra']['first_name'],
          :last_name  => raw_info['extra']['last_name']
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/josh_id/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
