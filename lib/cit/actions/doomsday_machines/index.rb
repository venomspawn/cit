# frozen_string_literal: true

module CIT
  need 'actions/base/action'

  module Actions
    module DoomsdayMachines
      # Class of actions which extract information on doomsday machines
      class Index < Base::Action
        require_relative 'index/params_schema'

        # Extracts and returns array with information on doomsday machines
        # @return [Array]
        #   resulting array
        def index
          dataset.to_a
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

        # Returns value of `page` parameter or zero if it's absent
        # @return [Integer]
        #   resulting value
        def page
          params[:page] || 0
        end

        # Value of page size which is used when `page_size` parameter's value
        # is absent
        DEFAULT_PAGE_SIZE = 10

        # Returns value of `page_size` parameter or {DEFAULT_PAGE_SIZE} if it's
        # absent
        # @return [Integer]
        #   resulting value
        def page_size
          params[:page_size] || DEFAULT_PAGE_SIZE
        end

        # Default sorting direction
        DEFAULT_DIRECTION = 'asc'

        # Returns value of `direction` parameter or {DEFAULT_DIRECTION} if it's
        # absent
        # @return [String]
        #   resulting value
        def direction
          params[:direction] || DEFAULT_DIRECTION
        end

        # Default column name for sorting
        DEFAULT_ORDER = 'id'

        # Returns Sequel expression for sorting based on `order` parameter
        # value or {DEFAULT_ORDER} if it's absent
        # @return [Sequel::SQL::OrderedExpression]
        #   resulting Sequel expression
        def order
          order = params[:order] || DEFAULT_ORDER
          order.to_sym.send(direction)
        end

        # Returns value of offset in dataset
        # @return [Integer]
        #   resulting value
        def offset
          page * page_size
        end

        # Sequel expression which is used to extract values of `created_at`
        # field in `doomsday_machines` table
        CREATED_AT =
          :to_char
          .sql_function(:created_at, 'YYYY-mm-dd HH:MM:SS')
          .as(:created_at)

        # Array which is used to extract values of fields of `doomsday_machines`
        # table
        COLUMNS = [:id, :name, :power, CREATED_AT].freeze

        # Sequel dataset of records of `doomsday_machines` table
        DATASET = Models::DoomsdayMachine.select(*COLUMNS).naked

        # Returns Sequel dataset of the required records of `doomsday_machines`
        # table
        # @return [Sequel::Dataset]
        #   resulting Sequel dataset
        def dataset
          DATASET
            .where(mad_scientist_id: mad_scientist.id)
            .order(order)
            .limit(page_size)
            .offset(offset)
        end
      end
    end
  end
end
