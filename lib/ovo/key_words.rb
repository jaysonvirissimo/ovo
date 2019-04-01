module Ovo
  module KeyWords
    def self.if(arguments, scope)
      raise ArgumentError unless arguments.length == 3

      # TODO: Think of a way to implement this without cheating
      if arguments.first
        Ovo::Evaluator.call(arguments[1], scope)
      else
        Ovo::Evaluator.call(arguments[2], scope)
      end
    end

    def self.print(value)
      puts value
      value
    end
  end
end
