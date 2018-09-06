# frozen_string_literal: true

require 'securerandom'

module CIT
  need 'actions/base/action'

  module Actions
    module MadScientists
      # Class of actions which create new records of mad scientists
      class Create < Base::Action
        require_relative 'create/params_schema'

        # Creates new record of a mad scientist and returns associative array
        # with information about the record
        # @return [Hash]
        #   resulting associative array
        def create
          record = Models::MadScientist.create(creation_params)
          { id: record.id }
        end

        private

        # Returns associative array of new record fields
        # @return [Hash]
        #   resulting associative array
        def creation_params
          params.dup.tap do |hash|
            hash[:id]         = SecureRandom.uuid
            hash[:created_at] = Time.now
          end
        end
      end
    end
  end
end
