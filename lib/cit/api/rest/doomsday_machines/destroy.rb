# frozen_string_literal: true

module CIT
  module API
    module REST
      module DoomsdayMachines
        # Provides definition of REST API method which destroys record of a
        # doomsday machine
        module Destroy
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Destroys record of a doomsday machine
            # @return [Status]
            #   204
            controller.delete '/doomsday_machines/:id' do |id|
              Actions::DoomsdayMachines.destroy(id: id)
              status :no_content
            end
          end
        end

        Controller.register Destroy
      end
    end
  end
end
