# frozen_string_literal: true

module CIT
  need 'actions/uuid_format'

  module Actions
    module MadScientists
      class Create
        # JSON-schema of action invocation's result
        RESULT_SCHEMA = {
          type: :object,
          properties: {
            id: {
              type: :string,
              pattern: UUID_FORMAT
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
