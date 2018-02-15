require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Clearbit < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://clearbit.com',
        authorize_url: 'https://clearbit.com/oauth/authorize',
        token_url: 'https://clearbit.com/oauth/access_token'
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
