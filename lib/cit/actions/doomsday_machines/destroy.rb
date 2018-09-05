# frozen_string_literal: true

module CIT
  need 'actions/base/action'

  module Actions
    module DoomsdayMachines
      # Class of actions which destroy records of doomsday machines
      class Destroy < Base::Action
        require_relative 'destroy/params_schema'

        # Destroys record of a doomsday machine
        def destroy
          record.destroy
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
          Models::DoomsdayMachine.with_pk!(id)
        end
      end
    end
  end
end
