# frozen_string_literal: true

module CIT
  need 'actions/uuid_format'

  module Actions
    module DoomsdayMachines
      class Create
        # JSON-schema of action parameters
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            mad_scientist_id: {
              type: :string,
              pattern: UUID_FORMAT
            },
            name: {
              type: :string
            },
            power: {
              type: :integer,
              minimum: 0
            }
          },
          required: %i[
            mad_scientist_id
            name
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
