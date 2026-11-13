require 'spec_helper'

describe OmniAuth::Strategies::Clearbit do
  let(:app) do
    Rack::Builder.new do
      use Rack::Session::Cookie, secret: 'x' * 64
      use OmniAuth::Strategies::Clearbit, 'client-id', 'client-secret'
      run ->(env) { [200, {}, [env['omniauth.auth'].to_hash.to_json]] }
    end
  end

  describe 'request phase' do
    it 'redirects to the Clearbit authorize URL with the client_id' do
      get '/auth/clearbit'

      expect(last_response.status).to eq(302)
      location = URI(last_response.headers['Location'])
      expect("#{location.scheme}://#{location.host}#{location.path}").to eq('https://clearbit.com/oauth/authorize')
      expect(Rack::Utils.parse_query(location.query)).to include('client_id' => 'client-id')
    end
  end

  describe 'callback phase' do
    before do
      stub_request(:post, 'https://clearbit.com/oauth/access_token')
        .with(body: hash_including('client_id' => 'client-id', 'client_secret' => 'client-secret', 'code' => 'code'))
        .to_return(
          headers: { 'Content-Type' => 'application/json' },
          body: { access_token: 'token', token_type: 'bearer' }.to_json
        )

      stub_request(:get, 'https://clearbit.com/oauth/account')
        .with(query: hash_including('access_token' => 'token'))
        .to_return(
          headers: { 'Content-Type' => 'application/json' },
          body: {
            id: 42,
            user: { email: 'alex@example.com', name: 'Alex' },
            plans: ['free']
          }.to_json
        )
    end

    it 'builds the auth hash from the account response' do
      get '/auth/clearbit'
      state = Rack::Utils.parse_query(URI(last_response.headers['Location']).query)['state']

      get '/auth/clearbit/callback', code: 'code', state: state

      auth = JSON.parse(last_response.body)
      expect(auth['provider']).to eq('clearbit')
      expect(auth['uid']).to eq('42')
      expect(auth['info']).to include(
        'email' => 'alex@example.com',
        'name'  => 'Alex',
        'plans' => ['free']
      )
      expect(auth['credentials']['token']).to eq('token')
    end
  end
end
