# frozen_string_literal: true

module CIT
  need 'actions/datetime_format'
  need 'actions/uuid_format'

  module Actions
    module MadScientists
      class Show
        # JSON-schema of action invocation's result
        RESULT_SCHEMA = {
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
              minimum: 0
            },
            created_at: {
              type: :string,
              pattern: DATETIME_FORMAT
            }
          },
          required: %i[
            id
            name
            madness
            tries
            created_at
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
