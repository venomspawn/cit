# frozen_string_literal: true

module CIT
  # Namespace of the models
  module Models
    # Model of a mad scientist
    # @!attribute id
    #   Identifier in UUID format
    #   @return [String]
    #     identifier in UUID format
    # @!attribute name
    #   Name
    #   @return [String]
    #     name
    # @!attribute madness
    #   Measure of madness
    #   @return [Integer]
    #     measure of madness
    # @!attribute tries
    #   Number of tries to destroy the Galaxy
    #   @return [Integer]
    #     number of tries to destroy the Galaxy
    # @!attribute created_at
    #   Date and time of record creation
    #   @return [Time]
    #     dand time of record creation
    class MadScientist < Sequel::Model
      unrestrict_primary_key
    end
  end
end
