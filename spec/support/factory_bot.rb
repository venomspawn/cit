# frozen_string_literal: true

require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.definition_file_paths = ["#{CIT.root}/spec/factories/"]
FactoryBot.find_definitions
