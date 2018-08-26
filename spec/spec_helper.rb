# frozen_string_literal: true

require 'rspec'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.expose_dsl_globally = false
end

require_relative '../config/app_init'

CIT::Init.run!

Dir["#{CIT.root}/spec/helpers/**/*.rb"].sort.each(&method(:require))
Dir["#{CIT.root}/spec/shared/**/*.rb"].sort.each(&method(:require))
Dir["#{CIT.root}/spec/support/**/*.rb"].sort.each(&method(:require))
