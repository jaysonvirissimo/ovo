require 'ostruct'
require_relative 'standard_library'

module Ovo
  class GlobalScope < OpenStruct
    include StandardLibrary

    def false
      false
    end

    def true
      true
    end
  end
end
