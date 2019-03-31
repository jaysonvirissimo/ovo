require_relative 'expression_parser'
require_relative 'space_skippable'

module Ovo
  class ExpressionApplier
    extend SpaceSkippable

    def self.call(expr, program)
      program = skip_spaces(program)
      return { expr: expr, rest: program } if program[0] != '('

      program = skip_spaces(program.chars.drop(1).join)
      apply_expression = ApplyExpression.new(expr)

      while program[0] != ')'
        arg = ExpressionParser.new(program).call
        apply_expression.add_argument(arg[:expr])
        program = skip_spaces(arg[:rest])

        if program[0] == ','
          program = skip_spaces(program.chars.drop(1).join)
        elsif program[0] != ')'
          raise "Expected ',' or ')'"
        end
      end

      call(apply_expression.to_h, program.slice(1))
    end
  end
end
