require 'daterval/version'
require 'active_support/all'

module Daterval
  extend ActiveSupport::Autoload

  autoload :Pair, 'daterval/pair'
  autoload :Set, 'daterval/set'
end
