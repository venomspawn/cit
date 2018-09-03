# frozen_string_literal: true

module CIT
  module API
    module REST
      module MadScientists
        # Provides definition of REST API method which returns information on a
        # mad scientist
        module Show
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Returns information on a mad scientist
            # @param [Hash] params
            #   associative array with structure described in
            #   {Actions::MadScientists::Show::PARAMS_SCHEMA JSON-schema}
            # @return [Array]
            #   array with structure described in
            #   {Actions::MadScientists::Show::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   200
            controller.get '/mad_scientists/:id' do |id|
              content = Actions::MadScientists.show(id: id)
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
