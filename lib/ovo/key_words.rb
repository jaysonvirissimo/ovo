module Ovo
  module KeyWords
    def self.if(arguments, scope)
      raise ArgumentError unless arguments.length == 3

      arguments.first &&
        Ovo::Evaluator.call(arguments[1], scope) ||
        Ovo::Evaluator.call(arguments[2], scope)
    end

    def self.print(value)
      puts value
      value
    end
  end
end
