# frozen_string_literal: true

module CIT
  module Actions
    module MadScientists
      class Index
        # JSON-schema of action parameters
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            page: {
              type: :integer,
              minimun: 0
            },
            page_size: {
              type: :integer,
              minimum: 1,
              maximum: 20
            },
            order: {
              type: :string,
              enum: Models::MadScientist.columns.map(&:to_s)
            },
            direction: {
              type: :string,
              enum: %w[asc desc]
            }
          },
          additionalProperties: false
        }.freeze
      end
    end
  end
end
