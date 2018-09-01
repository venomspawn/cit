# frozen_string_literal: true

module CIT
  module Models
    # Model of a doomsday machine
    # @!attribute id
    #   Identifier in UUID format
    #   @return [String]
    #     identifier in UUID format
    # @!attribute name
    #   Name
    #   @return [String]
    #     name
    # @!attribute power
    #   Destructive power
    #   @return [Integer]
    #     destructive power
    # @!attribute created_at
    #   Date and time of record creation
    #   @return [Time]
    #     dand time of record creation
    # @!attribute mad_scientist_id
    #   Identifier of the owner's record
    #   @return [String]
    #     identifier of the owner's record
    class DoomsdayMachine < Sequel::Model
      unrestrict_primary_key
    end
  end
end
