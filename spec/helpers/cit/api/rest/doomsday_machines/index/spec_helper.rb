# frozen_string_literal: true

module CIT
  need 'actions/doomsday_machines/index/result_schema'

  module API
    module REST
      module DoomsdayMachines
        module Index
          # Provides methods used in tests of REST API method defined in
          # containing module
          module SpecHelper
            # Returns JSON-schema of REST API method result
            # @return [Hash]
            #   JSON-schema of of REST API method result
            def schema
              Actions::DoomsdayMachines::Index::RESULT_SCHEMA
            end
          end
        end
      end
    end
  end
end
