# frozen_string_literal: true

module CIT
  need 'actions/base/action'

  module Actions
    module DoomsdayMachines
      # Class of actions which update information on doomsday machines
      class Update < Base::Action
        require_relative 'update/params_schema'

        # Updates information on a doomsday machine
        def update
          record.update(update_params)
        end

        private

        # Returns value of `id` parameter
        # @return [String]
        #   value of `id` parameter
        def id
          params[:id]
        end

        # Returns record of the doomsday machine with {id} identifier
        # @return [CIT::Models::DoomsdayMachine]
        #   the record
        # @raise [Sequel::NoMatchingRow]
        #   if the record can't be found by {id} identifier
        def record
          Models::DoomsdayMachine.select(:id).with_pk!(id)
        end

        # Returns associative array of new values
        # @return [Hash]
        #   resulting associative array
        def update_params
          params.except(:id)
        end
      end
    end
  end
end
