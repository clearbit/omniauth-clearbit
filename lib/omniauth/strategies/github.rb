module OmniAuth
  module Strategies
    class Clearbit < OmniAuth::Strategies::OAuth2
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
