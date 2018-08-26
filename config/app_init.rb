# frozen_string_literal: true

# Common initialization

require 'dotenv'

root = File.absolute_path("#{__dir__}/..")

# Loading of environment variables
Dotenv.load(File.absolute_path("#{root}/.env.#{ENV['RACK_ENV']}"))

# Loading of root module
require "#{root}/lib/cit"

# Configuring of initialization system
CIT::Init.configure do |settings|
  settings.set :initializers, "#{__dir__}/initializers"
  settings.set :root, root
end
