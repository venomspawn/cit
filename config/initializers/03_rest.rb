# frozen_string_literal: true

CIT.need 'api/rest/controller'
CIT.need 'api/rest/logger'
CIT.need 'api/rest/**/*'

CIT::API::REST::Controller.configure do |settings|
  settings.set :bind, ENV['CIT_BIND_HOST']
  settings.set :port, ENV['CIT_PORT']

  settings.disable :show_exceptions
  settings.disable :dump_errors
  settings.enable  :raise_errors

  settings.use CIT::API::REST::Logger

  settings.enable :static
  settings.set    :root, CIT.root
end

CIT::API::REST::Controller.configure :production do |settings|
  settings.set :server, :puma
end
