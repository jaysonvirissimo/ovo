module Ovo
  class ApplyEvaluator
    def initialize(expression, scope)
      @expression = expression
      @scope = scope
    end

    def call
      if scope.respond_to?(operator_name)
        scope.send(operator_name, arguments)
      elsif key_word?
        KeyWords.send(operator_name, arguments, scope)
      else
        raise TypeError
      end
    end

    private

    attr_reader :expression, :scope

    def arguments
      expression.arguments
    end

    def key_word?
      operator.type == 'word' && KeyWords.respond_to?(operator_name)
    end

    def operator
      expression.operator
    end

    def operator_name
      operator.name
    end
  end
end
