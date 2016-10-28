require 'date'
module Converter
  class DateConverter < Date
    def initialize(year, month, day)
      super
    end

    def to_american_format
      return self.strftime("%Y-%m-%d")
    end

    def to_conventional_format
      return self.strftime("%d-%m-%Y")
    end
  end
end