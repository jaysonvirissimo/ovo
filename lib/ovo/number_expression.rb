require_relative 'abstract_expression'

module Ovo
  class NumberExpression < AbstractExpression
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
      Integer(match.first)
    end

    private

    def pattern
      /^\d+\b/
    end
  end
end
