# frozen_string_literal: true

module CIT
  module Actions
    # Format of hex digit
    HEX = '[a-fA-F0-9]'

    # Regexp to check if a string is in UUID format
    UUID_FORMAT = /\A#{HEX}{8}-#{HEX}{4}-#{HEX}{4}-#{HEX}{4}-#{HEX}{12}\z/
  end
end
