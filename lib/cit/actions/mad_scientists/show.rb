# frozen_string_literal: true

module CIT
  need 'actions/base/action'

  module Actions
    module MadScientists
      # Class of actions which extract information on mad scientist
      class Show < Base::Action
        require_relative 'show/params_schema'

        # Sequel expression which is used to extract value of `created_at`
        # field in `mad_scientists` table
        CREATED_AT =
          :to_char
          .sql_function(:created_at, 'YYYY-mm-dd HH:MM:SS')
          .as(:created_at)

        # Array which is used to extract values of fields of `mad_scientists`
        # table
        COLUMNS = [:id, :name, :madness, :tries, CREATED_AT].freeze

        # Sequel dataset of records of `mad_scientists` table
        DATASET = Models::MadScientist.select(*COLUMNS).naked

        # Extracts and returns associative array with information on mad
        # scientist
        # @return [Hash]
        #   resulting associative array
        def show
          DATASET.with_pk!(id)
        end

        private

        # Returns value of `id` parameter
        # @return [String]
        #   value of `id` parameter
        def id
          params[:id]
        end
      end
    end
  end
end
