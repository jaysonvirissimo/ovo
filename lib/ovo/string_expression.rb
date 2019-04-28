require_relative 'abstract_expression'

module Ovo
  class StringExpression < AbstractExpression
    def program_remaining
      program.chars.drop(match.first.length).join
    end

    def type
      'value'
    end

    def valid?
      match.length.positive?
    end

    def value
      match[1]
    end

    private

    def pattern
      /^"([^"]*)"/
    end
  end
end
