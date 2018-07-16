module Daterval
  class Pair
    def initialize(begin_time, end_time)
      begin_time = Time.parse(begin_time) if begin_time.is_a?(String)
      end_time = Time.parse(end_time) if end_time.is_a?(String)

      begin_time, end_time = end_time, begin_time if end_time < begin_time

      @range = begin_time..end_time
    end

    def begin
      range.begin
    end

    def end
      range.end
    end

    def to_i
      range.end.to_i - range.begin.to_i
    end

    def ==(other)
      range.begin == other.begin && range.end == other.end
    end

    def overlaps?(other)
      range.overlaps?(other.range)
    end

    def overlap(other)
      begin_time = range.begin < other.begin ? range.begin : other.begin
      end_time = range.end > other.end ? range.end : other.end

      self.class.new(begin_time, end_time)
    end

    attr_accessor :range
  end
end
