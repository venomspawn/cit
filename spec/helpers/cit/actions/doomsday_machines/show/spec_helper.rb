# frozen_string_literal: true

module CIT
  need 'actions/doomsday_machines/show/result_schema'

  module Actions
    module DoomsdayMachines
      class Show
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
