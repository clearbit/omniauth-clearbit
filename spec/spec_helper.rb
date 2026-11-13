$:.unshift File.expand_path('../../lib', __FILE__)

require 'rack/session'
require 'rack/test'
require 'webmock/rspec'
require 'omniauth-clearbit'

OmniAuth.config.logger = Logger.new(nil)
OmniAuth.config.allowed_request_methods = %i[get post]
OmniAuth.config.silence_get_warning = true if OmniAuth.config.respond_to?(:silence_get_warning=)

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
