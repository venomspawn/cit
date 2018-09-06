# frozen_string_literal: true

module CIT
  need 'actions/base/action'

  module Actions
    module MadScientists
      # Class of actions which extract information on mad scientists
      class Index < Base::Action
        require_relative 'index/params_schema'

        # Extracts and returns array with information on mad scientists
        # @return [Array]
        #   resulting array
        def index
          dataset.to_a
        end

        private

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
        # field in `mad_scientists` table
        CREATED_AT =
          :to_char
          .sql_function(:created_at, 'YYYY-mm-dd HH:MM:SS')
          .as(:created_at)

        # Array which is used to extract values of fields of `mad_scientists`
        # table
        COLUMNS = [
          :id,
          :name,
          :madness,
          :tries,
          CREATED_AT
        ].freeze

        # Sequel dataset of records of `mad_scientists` table
        DATASET = Models::MadScientist.select(*COLUMNS).naked

        # Returns Sequel dataset of the required records of `mad_scientists`
        # table
        # @return [Sequel::Dataset]
        #   resulting Sequel dataset
        def dataset
          DATASET.order(order).limit(page_size).offset(offset)
        end
      end
    end
  end
end
