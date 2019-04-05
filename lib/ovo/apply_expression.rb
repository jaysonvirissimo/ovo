module Ovo
  class ApplyExpression
    def initialize(operator)
      @arguments = []
      @operator = operator
    end

    def to_h
      { type: 'apply', operator: operator, arguments: arguments }
    end

    def add_argument(argument)
      @arguments.push(argument)
    end

    private

    attr_reader :arguments, :operator
  end
end
