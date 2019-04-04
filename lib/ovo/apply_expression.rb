module Ovo
  class ApplyExpression
    def initialize(operator)
      @arguments = []
      @operator = operator
    end

    def to_h
      # TODO: Be consistent about args versus arguments.
      { type: 'apply', operator: operator, args: arguments }
    end

    def add_argument(argument)
      @arguments.push(argument)
    end

    private

    attr_reader :arguments, :operator
  end
end
