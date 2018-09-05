# frozen_string_literal: true

module CIT
  module API
    module REST
      module DoomsdayMachines
        # Provides definition of REST API method which updates information on a
        # doomsday machine
        module Update
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Updates information on a doomsday machine
            # @param [String] request_body
            #   JSON-string of structure described in
            #   {Actions::DoomsdayMachines::Update::PARAMS_SCHEMA JSON-schema}
            # @return [Status]
            #   204
            controller.put '/doomsday_machines/:id' do |id|
              Actions::DoomsdayMachines.update(request.body, id: id)
              status :no_content
            end
          end
        end

        Controller.register Update
      end
    end
  end
end
