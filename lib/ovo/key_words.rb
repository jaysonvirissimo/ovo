module Ovo
  module KeyWords
    def self.do(arguments, scope)
      arguments.each_with_object(value: nil) do |argument, hash|
        hash[:value] = Ovo::Evaluator.call(argument, scope)
      end[:value]
    end

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
