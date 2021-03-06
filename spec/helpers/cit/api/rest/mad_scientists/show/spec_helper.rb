# frozen_string_literal: true

module CIT
  need 'actions/mad_scientists/show/result_schema'

  module API
    module REST
      module MadScientists
        module Show
          # Provides methods used in tests of REST API method defined in
          # containing module
          module SpecHelper
            # Returns JSON-schema of REST API method result
            # @return [Hash]
            #   JSON-schema of of REST API method result
            def schema
              Actions::MadScientists::Show::RESULT_SCHEMA
            end
          end
        end
      end
    end
  end
end
