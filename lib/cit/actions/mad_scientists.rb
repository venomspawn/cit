# frozen_string_literal: true

module CIT
  module Actions
    # Provides functions to access actions on records of mad scientists
    module MadScientists
      require_relative 'mad_scientists/create'

      # Creates new record of a mad scientist and returns associative array
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

      require_relative 'mad_scientists/destroy'

      # Destroys record of a mad scientist
      # @param [Object] params
      #   object of action parameters, which can be an associative array, a
      #   JSON-string or an object with `#read` method
      # @param [NilClass, Hash] rest
      #   associative array of additional action parameters or `nil`, if
      #   there are no additional parameters
      def self.destroy(params, rest = nil)
        Destroy.new(params, rest).destroy
      end

      require_relative 'mad_scientists/index'

      # Extracts and returns array with information on mad scientists
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
    end
  end
end
