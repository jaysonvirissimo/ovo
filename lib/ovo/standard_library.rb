module Ovo
  module StandardLibrary
    ['+', '-', '>', '<', '*', '/', '%'].each do |operator|
      define_method(operator) do |a, b|
        a.send(operator, b)
      end
    end
  end
end
