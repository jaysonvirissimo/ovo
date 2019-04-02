module Ovo
  class ValueEvaluator
    def initialize(expression, _scope)
      @expression = expression
    end

    def call
      expression[:value]
    end

    attr_reader :expression
  end
end
