require_relative 'string_expression'
require_relative 'number_expression'
require_relative 'word_expression'

module Ovo
  class Parser
    EXPRESSION_TYPES = [StringExpression, NumberExpression, WordExpression].freeze

    def self.call(program)
      result = parse_expression(program)
      expression = result[:expr]
      rest = result[:rest]

      raise 'Unexpected text after program' if skip_spaces(rest).length.positive?

      expression
    end

    def self.parse_expression(program)
      program = skip_spaces(program)

      expression = EXPRESSION_TYPES.map do |expression_type|
        expression_type.new(program)
      end.find(&:valid?)

      raise SyntaxError.new("Unexpected syntax: #{program}") if expression.nil?

      parse_apply(expression.to_h, expression.program_remaining)
    end

    def self.parse_apply(expr, program)
      program = skip_spaces(program)
      return { expr: expr, rest: program } if program[0] != '('

      program = skip_spaces(program.chars.drop(1).join)
      expr = { type: 'apply', operator: expr, args: [] }

      while program[0] != ')'
        arg = parse_expression(program)
        expr[:args].push(arg[:expr])
        program = skip_spaces(arg[:rest])

        if program[0] == ','
          program = skip_spaces(program.chars.drop(1).join)
        elsif program[0] != ')'
          raise "Expected ',' or ')'"
        end
      end

      parse_apply(expr, program.slice(1))
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
