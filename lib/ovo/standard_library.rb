module Ovo
  module StandardLibrary
    ['+', '-', '>', '<', '*', '/', '%'].each do |operator|
      define_method(operator) do |arguments|
        arguments[0].send(operator, arguments[1])
      end
    end
  end
end
