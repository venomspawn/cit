# frozen_string_literal: true

module CIT
  module API
    module REST
      # Provides definitions of REST API methods which handle records of mad
      # scientists
      module MadScientists
        # Provides definition of REST API method which creates new record of a
        # mad scientist
        module Create
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Creates new record of a mad scientist and returns information
            # about the record
            # @return [Hash]
            #   associative array with structure described in
            #   {Actions::MadScientists::Create::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   201
            controller.post '/mad_scientists' do
              content = Actions::MadScientists.create(request.body)
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
