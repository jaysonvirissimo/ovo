require_relative 'value_evaluator'

module Ovo
  class Evaluator
    def self.call(expression, scope)
      new(expression, scope).call
    end

    def initialize(expression, scope)
      @expression = expression
      @scope = scope
    end

    def call
      self.class.const_get("Ovo::#{expression[:type].capitalize}Evaluator")
        .new(expression, scope)
        .call
    end

    private

    attr_reader :expression, :scope
  end
end
