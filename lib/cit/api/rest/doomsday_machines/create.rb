# frozen_string_literal: true

module CIT
  module API
    module REST
      # Provides definitions of REST API methods which handle records of mad
      # scientists
      module DoomsdayMachines
        # Provides definition of REST API method which creates new record of a
        # doomsday machine
        module Create
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Creates new record of a doomsday machine and returns information
            # about the record
            # @param [String] request_body
            #   JSON-string of structure described in
            #   {Actions::DoomsdayMachines::Create::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   JSON-string of structure described in
            #   {Actions::DoomsdayMachines::Create::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   201
            controller.post '/mad_scientists/:id/doomsday_machines' do |id|
              rest = { mad_scientist_id: id }
              content = Actions::DoomsdayMachines.create(request.body, rest)
              status :created
              body Oj.dump(content)
            end
          end
        end

        Controller.register Create
      end
    end
  end
end
