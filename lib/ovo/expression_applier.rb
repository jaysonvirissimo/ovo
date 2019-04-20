require_relative 'expression_parser'
require_relative 'space_skippable'

module Ovo
  class ExpressionApplier
    include SpaceSkippable

    def self.call(expression, program)
      new(expression, program).call
    end

    def initialize(expression, program)
      @expression = expression
      @program = skip_spaces(program)
    end

    def call
      if start_of_arguments?
        continue_reading_at(program.chars.drop(1).join)
        apply_expression
        add_arguments
        self.class.new(applied_expression.to_h, program.chars.drop(1).join).call
      else
        { expression: expression, rest: program }
      end
    end

    private

    attr_reader :applied_expression, :expression
    attr_accessor :program

    def add_arguments
      until end_of_arguments?
        next_argument = ExpressionParser.new(program).call
        applied_expression.add_argument(next_argument[:expression])
        continue_reading_at(next_argument[:rest])

        if argument_separator?
          continue_reading_at(program.chars.drop(1).join)
        elsif !end_of_arguments?
          raise SyntaxError, "Expected ',' or ')'"
        end
      end
    end

    def apply_expression
      @applied_expression = ApplyExpression.new(expression)
    end

    def argument_separator?
      program[0] == ','
    end

    def continue_reading_at(program)
      self.program = skip_spaces(program)
    end

    def end_of_arguments?
      program[0] == ')'
    end

    def start_of_arguments?
      program[0] == '('
    end
  end
end
