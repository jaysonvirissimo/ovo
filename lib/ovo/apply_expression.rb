module Ovo
  class ApplyExpression
    attr_reader :arguments, :operator

    def initialize(operator)
      @arguments = []
      @operator = operator
    end

    def type
      'apply'
    end

    def add_argument(argument)
      @arguments.push(argument)
    end
  end
end
