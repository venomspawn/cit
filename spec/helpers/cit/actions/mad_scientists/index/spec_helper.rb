# frozen_string_literal: true

module CIT
  need 'actions/mad_scientists/index/result_schema'

  module Actions
    module MadScientists
      class Index
        # Provides methods to use in tests of containing class
        module SpecHelper
          # Returns JSON-schema of action result
          # @return [Hash]
          #   JSON-schema of action result
          def schema
            RESULT_SCHEMA
          end

          # Array of names of the fields of `mad_scientists` table
          COLUMNS = %i[id name madness tries created_at].freeze

          # Array with values of test records of mad scientists
          MAD_SCIENTISTS = [
            ['8abd8754-e1eb-459e-b71a-c0247d58139f', '1', 2, 3, Time.now - 1],
            ['2d1d9454-a5de-4bb9-ab24-c73032e8252b', '2', 1, 4, Time.now - 2],
            ['6b3e3022-3726-41dd-8cf0-726b3a90f546', '3', 0, 5, Time.now - 3]
          ].freeze

          # Creates records of mad scientists and returns array of them
          # @return [Array]
          #   resulting array
          def create_mad_scientists
            MAD_SCIENTISTS.map do |values|
              params = Hash[COLUMNS.zip(values)]
              Models::MadScientist.create(params)
            end
          end
        end
      end
    end
  end
end
