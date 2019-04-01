module Ovo
  module KeyWords
    def self.if(arguments, _scope)
      raise ArgumentError unless arguments.length == 3
    end

    def self.print(value)
      puts value
      value
    end
  end
end
