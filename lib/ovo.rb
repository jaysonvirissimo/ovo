require 'ovo/evaluator'
require 'ovo/version'
require 'ovo/parser'
require 'ovo/global_scope'
require 'ovo/key_words'

module Ovo
  def self.run(program)
    Evaluator.call(Parser.call(program), GlobalScope.new)
  end
end
