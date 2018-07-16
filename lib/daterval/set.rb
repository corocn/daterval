module Daterval
  class Set
    include Enumerable

    def initialize(*pairs)
      @list = pairs
    end

    def each
      list.each { |pair| yield pair }
    end

    def merged!
      sorted = list.sort_by(&:begin)
      new_list = []

      sorted.each do |pair|
        merged = false

        new_list.each_with_index do |pair_x, index_x|
          if pair.overlaps?(pair_x)
            new_list[index_x] = pair.overlap(pair_x)
            merged = true
          end
        end

        new_list << pair unless merged
      end

      @list = new_list
      self
    end

    attr_accessor :list
  end
end
