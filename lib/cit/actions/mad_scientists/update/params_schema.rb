# frozen_string_literal: true

module CIT
  need 'actions/uuid_format'

  module Actions
    module MadScientists
      class Update
        # JSON-schema of action parameters
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            id: {
              type: :string,
              pattern: UUID_FORMAT
            },
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
            id
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
