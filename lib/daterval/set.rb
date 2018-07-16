module Daterval
  class Set
    include Enumerable

    def initialize(*pairs)
      @list = pairs
    end

    def each
      @list.each { |pair| yield pair }
    end

    private

    attr_accessor :list
  end
end
