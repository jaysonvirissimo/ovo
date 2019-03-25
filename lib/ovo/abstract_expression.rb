module Ovo
  class AbstractExpression
    def initialize(program)
      @program = program
    end

    def to_h
      raise NotImplementedError
    end

    def program_remaining
      raise NotImplementedError
    end

    def valid?
      raise NotImplementedError
    end

    private

    attr_reader :program
  end
end
