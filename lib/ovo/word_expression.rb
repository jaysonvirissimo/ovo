require_relative 'abstract_expression'

module Ovo
  class WordExpression < AbstractExpression
    def to_h
      { type: 'word', name: match.first }
    end

    def program_remaining
      program.chars.drop(match.first.length).join
    end

    def valid?
      match.length.positive?
    end

    private

    PATTERN = /^[^\s(),#"]+/

    def match
      @match ||= program.scan(PATTERN)
    end
  end
end
