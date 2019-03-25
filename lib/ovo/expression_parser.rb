require_relative 'parser'

module Ovo
  class ExpressionParser
    ATOMIC_ELEMENTS = [
      StringExpression,
      NumberExpression,
      WordExpression
    ].freeze

    def initialize(program)
      @program = program&.strip || ''
    end

    def call
      if expression.nil?
        raise SyntaxError, "Unexpected syntax: #{program}"
      else
        Parser.parse_apply(expression.to_h, expression.program_remaining)
      end
    end

    private

    attr_reader :program

    def expression
      @expression ||= ATOMIC_ELEMENTS.map do |expression_type|
        expression_type.new(program)
      end.find(&:valid?)
    end
  end
end
