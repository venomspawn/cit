# frozen_string_literal: true

module CIT
  module API
    module REST
      module DoomsdayMachines
        # Provides definition of REST API method which returns information on
        # doomsday machines
        module Index
          # Registers REST API method in REST API controller
          # @param [CIT::API::REST::Controller] controller
          #   REST API controller
          def self.registered(controller)
            # Returns information on doomsday machines
            # @param [String] request_body
            #   JSON-string of structure described in
            #   {Actions::DoomsdayMachines::Index::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   JSON-string of structure described in
            #   {Actions::DoomsdayMachines::Index::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   200
            controller.get '/mad_scientists/:id/doomsday_machines' do |id|
              rest = { mad_scientist_id: id }
              content = Actions::DoomsdayMachines.index(request.GET, rest)
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
