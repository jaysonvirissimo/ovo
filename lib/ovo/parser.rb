require_relative 'apply_expression'
require_relative 'string_expression'
require_relative 'number_expression'
require_relative 'word_expression'
require_relative 'expression_parser'
require_relative 'space_skippable'

module Ovo
  class Parser
    extend SpaceSkippable

    def self.call(program)
      ExpressionParser.new(program).call.tap do |result|
        if skip_spaces(result[:rest]).length.positive?
          raise SyntaxError, 'Unexpected text after program'
        end
      end[:expression]
    end
  end
end
