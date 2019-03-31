require_relative 'parser'
require_relative 'expression_applier'
require_relative 'space_skippable'

module Ovo
  class ExpressionParser
    include SpaceSkippable

    ATOMIC_ELEMENTS = [
      StringExpression,
      NumberExpression,
      WordExpression
    ].freeze

    def initialize(program)
      @program = skip_spaces(program)
    end

    def call
      if expression.nil?
        raise SyntaxError, "Unexpected syntax: #{program}"
      else
        ExpressionApplier.call(expression.to_h, expression.program_remaining)
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
