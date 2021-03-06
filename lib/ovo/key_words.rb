module Ovo
  module KeyWords
    def self.define(arguments, scope)
      raise ArgumentError unless arguments.length == 2

      Ovo::Evaluator.call(arguments[1], scope).tap do |evaluated|
        scope.send("#{arguments[0].name}=", evaluated)
      end
    end

    def self.do(arguments = [], scope)
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

    def self.print(arguments, scope)
      expression = arguments.first

      if expression.type == 'value'
        puts expression.value
        expression.value
      elsif expression.type == 'word'
        value = scope.send(expression.name)
        puts value
        value
      else
        fail
      end
    end

    def self.while(arguments, scope)
      raise ArgumentError unless arguments.length == 2

      (0..).each do |_index|
        break unless Ovo::Evaluator.call(arguments[0], scope)
        Ovo::Evaluator.call(arguments[1], scope)
      end

      false
    end
  end
end
