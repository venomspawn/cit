# frozen_string_literal: true

module CIT
  module Actions
    # Provides functions to access actions on records of doomsday machines
    module DoomsdayMachines
      require_relative 'doomsday_machines/create'

      # Creates new record of a doomsday machines and returns associative array
      # with information about the record
      # @param [Object] params
      #   object of action parameters, which can be an associative array, a
      #   JSON-string or an object with `#read` method
      # @param [NilClass, Hash] rest
      #   associative array of additional action parameters or `nil`, if
      #   there are no additional parameters
      # @return [Hash]
      #   resulting associative array
      def self.create(params, rest = nil)
        Create.new(params, rest).create
      end

      require_relative 'doomsday_machines/destroy'

      # Destroys record of a doomsday machine
      # @param [Object] params
      #   object of action parameters, which can be an associative array, a
      #   JSON-string or an object with `#read` method
      # @param [NilClass, Hash] rest
      #   associative array of additional action parameters or `nil`, if
      #   there are no additional parameters
      def self.destroy(params, rest = nil)
        Destroy.new(params, rest).destroy
      end

      require_relative 'doomsday_machines/index'

      # Extracts and returns array with information on doomsday machines
      # @param [Object] params
      #   object of action parameters, which can be an associative array, a
      #   JSON-string or an object with `#read` method
      # @param [NilClass, Hash] rest
      #   associative array of additional action parameters or `nil`, if
      #   there are no additional parameters
      # @return [Array]
      #   resulting array
      def self.index(params, rest = nil)
        Index.new(params, rest).index
      end

      require_relative 'doomsday_machines/show'

      # Extracts and returns associative array with information on doomsday
      # machine
      # @param [Object] params
      #   object of action parameters, which can be an associative array, a
      #   JSON-string or an object with `#read` method
      # @param [NilClass, Hash] rest
      #   associative array of additional action parameters or `nil`, if
      #   there are no additional parameters
      # @return [Hash]
      #   resulting associative array
      def self.show(params, rest = nil)
        Show.new(params, rest).show
      end
    end
  end
end
