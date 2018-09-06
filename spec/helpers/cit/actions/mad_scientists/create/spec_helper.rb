# frozen_string_literal: true

module CIT
  need 'actions/mad_scientists/create/result_schema'

  module Actions
    module MadScientists
      class Create
        # Provides methods to use in tests of containing class
        module SpecHelper
          # Returns JSON-schema of action result
          # @return [Hash]
          #   JSON-schema of action result
          def schema
            RESULT_SCHEMA
          end
        end
      end
    end
  end
end
