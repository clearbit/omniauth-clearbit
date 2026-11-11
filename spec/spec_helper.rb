$:.unshift File.expand_path('../../lib', __FILE__)

require 'rack/test'
require 'webmock/rspec'
require 'omniauth-clearbit'

OmniAuth.config.logger = Logger.new(nil)

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
