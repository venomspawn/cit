# frozen_string_literal: true

module CIT
  module API
    module REST
      module MadScientists
        # Provides definition of REST API method which destroys record of a
        # mad scientist
        module Destroy
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Destroys record of a mad scientist
            # @return [Status]
            #   204
            controller.delete '/mad_scientists/:id' do |id|
              Actions::MadScientists.destroy(id: id)
              status :no_content
            end
          end
        end

        Controller.register Destroy
      end
    end
  end
end
