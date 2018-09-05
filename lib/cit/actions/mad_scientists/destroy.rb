# frozen_string_literal: true

module CIT
  need 'actions/base/action'

  module Actions
    module MadScientists
      # Class of actions which destroy records of mad scientists
      class Destroy < Base::Action
        require_relative 'destroy/params_schema'

        # Destroys record of a mad scientist
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

        # Returns record of the mad scientist with {id} identifier
        # @return [CIT::Models::MadScientist]
        #   the record
        # @raise [Sequel::NoMatchingRow]
        #   if the record can't be found by {id} identifier
        def record
          Models::MadScientist.with_pk!(id)
        end
      end
    end
  end
end
