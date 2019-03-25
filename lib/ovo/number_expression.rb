require_relative 'abstract_expression'

module Ovo
  class NumberExpression < AbstractExpression
    def to_h
      { type: 'value', value: Integer(match.first) }
    end

    def program_remaining
      program.chars.drop(match.first.length).join
    end

    def valid?
      match.length.positive?
    end

    private

    PATTERN = /^\d+\b/

    def match
      @match ||= program.scan(PATTERN)
    end
  end
end
