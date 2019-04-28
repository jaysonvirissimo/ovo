module Ovo
  module StandardLibrary
    ['+', '-', '>', '<', '*', '/', '%'].each do |operator|
      define_method(operator) do |arguments|
        a = if arguments[0].type == 'value'
              arguments[0].value
            else
              send(arguments[0].name)
        end
        b = if arguments[1].type == 'value'
              arguments[1].value
            else
              send(arguments[1].name)
        end

        a.send(operator, b)
      end
    end
  end
end
