require 'time'
module Converter
  class TimeConverter < Time
    attr_accessor :format, :hour, :minutes

    def initialize(hour, minutes)
      @hour, @minutes = hour, minutes
      @format = convert
    end
    
    def convert
      return Time.parse("#{@hour}:#{@minutes}")
    end

    def to_format
      @format.strftime("%H:%M")
    end
  end
end