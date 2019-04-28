module Ovo
  class AbstractExpression
    def initialize(program)
      @program = program
    end

    def program_remaining
      raise NotImplementedError
    end

    def type
      raise NotImplementedError
    end

    def valid?
      raise NotImplementedError
    end

    private

    attr_reader :program

    def match
      @match ||= program.scan(pattern)
    end
  end
end
