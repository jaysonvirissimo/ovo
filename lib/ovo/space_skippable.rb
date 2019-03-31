module Ovo
  module SpaceSkippable
    def skip_spaces(string)
      if string.nil?
        ''
      else
        string.strip
      end
    end
  end
end
