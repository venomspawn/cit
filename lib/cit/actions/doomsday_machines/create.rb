# frozen_string_literal: true

require 'securerandom'

module CIT
  need 'actions/base/action'

  module Actions
    module DoomsdayMachines
      # Class of actions which create new records of doomsday machines
      class Create < Base::Action
        require_relative 'create/params_schema'

        # Creates new record of a mad scientist and returns associative array
        # with information about the record
        # @return [Hash]
        #   resulting associative array
        def create
          record = Models::DoomsdayMachine.create(creation_params)
          { id: record.id }
        end

        private

        # Returns value of `mad_scientist_id` parameter
        # @return [String]
        #   value of `mad_scientist_id` parameter
        def mad_scientist_id
          params[:mad_scientist_id]
        end

        # Returns record of the mad scientist with {mad_scientist_id}
        # identifier
        # @return [CIT::Models::MadScientist]
        #   record of the mad mascientist
        # @raise [Sequel::NoMatchingRow]
        #   if the record can't be found by {mad_scientist_id} identifier
        def mad_scientist
          Models::MadScientist.with_pk!(mad_scientist_id)
        end

        # Returns associative array of new record fields
        # @return [Hash]
        #   resulting associative array
        def creation_params
          params.slice(:name, :power).tap do |hash|
            hash[:mad_scientist_id] = mad_scientist.id
            hash[:id]               = SecureRandom.uuid
            hash[:created_at]       = Time.now
          end
        end
      end
    end
  end
end
