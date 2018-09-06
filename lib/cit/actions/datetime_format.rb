# frozen_string_literal: true

module CIT
  module Actions
    # Regexp to check if a string is a proper date representation
    DATE = /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])/

    # Regexp to check if a string is a proper time representation
    TIME = /(2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9]/

    # Regexp to check if a string is a proper date and time representation
    DATETIME_FORMAT = /\A#{DATE} #{TIME}\z/
  end
end
