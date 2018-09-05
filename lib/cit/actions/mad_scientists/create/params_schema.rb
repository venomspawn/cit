# frozen_string_literal: true

module CIT
  module Actions
    module MadScientists
      class Create
        # JSON-schema of action parameters
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            name: {
              type: :string
            },
            madness: {
              type: :integer,
              minimum: 0
            },
            tries: {
              type: :integer,
              minimun: 0
            }
          },
          required: %i[
            name
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
