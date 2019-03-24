module Ovo
  class Parser
    EXPRESSION_TYPES = {
      string: /^"([^"]*)"/,
      number: /^\d+\b/,
      word: /^[^\s(),#"]+/
    }.freeze

    def self.call(program)
      result = parse_expression(program)
      expression = result[:expr]
      rest = result[:rest]

      raise 'Unexpected text after program' if skip_spaces(rest).length.positive?

      expression
    end

    def self.parse_expression(program)
      program = skip_spaces(program)
      match = nil

      expression_type = EXPRESSION_TYPES.find do |_type, pattern|
        match = program.scan(pattern)
        match.length.positive?
      end

      expression = case expression_type.first
                   when :string
                     { type: 'value', value: match[1] }
                   when :number
                     { type: 'value', value: match[0].to_i }
                   when :word
                     { type: 'word', value: match[0] }
                   else
                     raise 'nope'
      end

      parse_apply(expression, program.chars.drop(match.first.length).join)
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
