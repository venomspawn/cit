# frozen_string_literal: true

module CIT
  module API
    module REST
      module DoomsdayMachines
        # Provides definition of REST API method which returns information on a
        # doomsday machine
        module Show
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Returns information on a doomsday machine
            # @param [String] request_body
            #   JSON-string of structure described in
            #   {Actions::DoomsdayMachines::Show::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   JSON-string of structure described in
            #   {Actions::DoomsdayMachines::Show::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   200
            controller.get '/doomsday_machines/:id' do |id|
              content = Actions::DoomsdayMachines.show(id: id)
              status :ok
              body Oj.dump(content)
            end
          end
        end

        Controller.register Show
      end
    end
  end
end
