module Ovo
  class WordEvaluator
    def initialize(expression, scope)
      @expression = expression
      @scope = scope
    end

    def call
      if scope.respond_to?(name)
        scope.send(name)
      else
        raise NameError
      end
    end

    private

    attr_reader :expression, :scope

    def name
      @name ||= expression.name
    end
  end
end
