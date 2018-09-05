# frozen_string_literal: true

module CIT
  need 'actions/doomsday_machines/index/result_schema'

  module Actions
    module DoomsdayMachines
      class Index
        # Provides methods to use in tests of containing class
        module SpecHelper
          # Returns JSON-schema of action result
          # @return [Hash]
          #   JSON-schema of action result
          def schema
            RESULT_SCHEMA
          end

          # Array of names of the fields of `doomsday_machines` table
          COLUMNS = %i[id name power created_at].freeze

          # Array with values of test records of doomsday machines
          DOOMSDAY_MACHINES = [
            ['8abd8754-e1eb-459e-b71a-c0247d58139f', '1', 3, Time.now - 1],
            ['2d1d9454-a5de-4bb9-ab24-c73032e8252b', '2', 4, Time.now - 2],
            ['6b3e3022-3726-41dd-8cf0-726b3a90f546', '3', 5, Time.now - 3]
          ].freeze

          # Creates records of doomsday machines and returns array of them
          # @param [String] mad_scientist_id
          #   identifier of record of a mad scientist
          # @return [Array]
          #   resulting array
          def create_doomsday_machines(mad_scientist_id)
            DOOMSDAY_MACHINES.map do |values|
              params = Hash[COLUMNS.zip(values)]
              params[:mad_scientist_id] = mad_scientist_id
              Models::DoomsdayMachine.create(params)
            end
          end
        end
      end
    end
  end
end
