# frozen_string_literal: true

module CIT
  need 'actions/uuid_format'

  module Actions
    module DoomsdayMachines
      class Index
        # JSON-schema of action parameters
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            mad_scientist_id: {
              type: :string,
              pattern: UUID_FORMAT
            },
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
              enum: Models::DoomsdayMachine.columns.map(&:to_s)
            },
            direction: {
              type: :string,
              enum: %w[asc desc]
            }
          },
          required: %i[
            mad_scientist_id
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
