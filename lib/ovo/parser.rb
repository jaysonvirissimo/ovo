require_relative 'apply_expression'
require_relative 'string_expression'
require_relative 'number_expression'
require_relative 'word_expression'
require_relative 'expression_parser'

module Ovo
  class Parser
    def self.call(program)
      ExpressionParser.new(program).call.tap do |result|
        if skip_spaces(result[:rest]).length.positive?
          raise SyntaxError, 'Unexpected text after program'
        end
      end[:expr]
    end

    def self.parse_apply(expr, program)
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

      parse_apply(apply_expression.to_h, program.slice(1))
    end

    def self.skip_spaces(string)
      if string.nil?
        ''
      else
        string.strip
      end
    end
  end
end
