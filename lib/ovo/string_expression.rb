require_relative 'abstract_expression'

module Ovo
  class StringExpression < AbstractExpression
    def to_h
      { type: 'value', value: match[1] }
    end

    def program_remaining
      program.chars.drop(match.first.length).join
    end

    def valid?
      match.length.positive?
    end

    private

    def pattern
      /^"([^"]*)"/
    end
  end
end
