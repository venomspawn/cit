# frozen_string_literal: true

require 'rack/test'

module Support
  module RackHelper
    include Rack::Test::Methods

    # REST API controller for tests
    def app
      CIT::API::REST::Controller
    end
  end
end

RSpec.configure do |config|
  config.include Support::RackHelper
end
