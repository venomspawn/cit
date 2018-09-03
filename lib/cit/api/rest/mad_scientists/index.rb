# frozen_string_literal: true

module CIT
  module API
    module REST
      module MadScientists
        # Provides definition of REST API method which returns information on
        # mad scientists
        module Index
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Returns information on mad scientists
            # @param [String] request_body
            #   JSON-string of structure described in
            #   {Actions::MadScientists::Index::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   JSON-string of structure described in
            #   {Actions::MadScientists::Index::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   200
            controller.get '/mad_scientists' do
              content = Actions::MadScientists.index(request.GET)
              status :ok
              body Oj.dump(content)
            end
          end
        end

        Controller.register Index
      end
    end
  end
end
