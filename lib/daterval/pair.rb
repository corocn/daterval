module Daterval
  class Pair
    def initialize(start_time, end_time)
      @start_time = start_time
      @end_time = end_time
      normalize!
    end

    attr_accessor :start_time, :end_time

    private

    def normalize!
      @start_time, @end_time = @end_time, @start_time if @end_time < @start_time
    end
  end
end
