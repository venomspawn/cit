# frozen_string_literal: true

require 'sequel'
require 'erb'
require 'yaml'

Sequel.extension :migration
Sequel.extension :core_extensions

# Loading of database connection's options
erb = IO.read("#{CIT.root}/config/database.yml")
yaml = ERB.new(erb).result
options = YAML.safe_load(yaml, [], [], true)

# Connecting to the database and setting logger
Sequel::Model.db = Sequel.connect(options[CIT.env]).tap do |settings|
  if CIT.production?
    settings.sql_log_level = :unknown
  else
    settings.loggers << CIT.logger if CIT.logger.present?
    settings.sql_log_level = :debug
  end
end
Sequel::Model.raise_on_save_failure = true
Sequel::Model.raise_on_typecast_failure = true
