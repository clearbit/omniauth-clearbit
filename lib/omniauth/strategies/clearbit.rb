require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Clearbit < OmniAuth::Strategies::OAuth2
      def self.site
        ENV['OMNIAUTH_STRATEGIES_CLEARBIT_SITE'] ||
          'https://clearbit.com'
      end

      def self.authorize_url
        ENV['OMNIAUTH_STRATEGIES_CLEARBIT_AUTHORIZE_URL'] ||
          'https://clearbit.com/oauth/authorize'
      end

      def self.token_url
        ENV['OMNIAUTH_STRATEGIES_CLEARBIT_TOKEN_URL'] ||
          'https://clearbit.com/oauth/access_token'
      end

      option :client_options, {
        site:          site,
        authorize_url: authorize_url,
        token_url:     token_url
      }

      uid { raw_info['id'].to_s }

      info do
        {
          'email' => raw_info['user']['email'],
          'name'  => raw_info['user']['name'],
          'plans' => raw_info['plans']
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/oauth/account').parsed
      end
    end
  end
end
