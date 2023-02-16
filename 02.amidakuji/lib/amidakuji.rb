# frozen_string_literal: true

class Amidakuji
  def self.generate(number)
    alphabets = ('A'..'Z').to_a
    choices = [alphabets[0, number].join('   ')]
    lines = choices + vertical_lines(number)
    lines.join("\n")
  end

  def self.vertical_lines(number)
    Array.new(number * 2, '｜   ｜   ｜   ｜   ｜')
  end
end

# ('A'..'Z').to_aもなんとかする
# selfをなんとかする
# ['A   B   C   D   E', '|  |  |  |  |', '|  |  |  |  |', '|  |  |  |  |']
# '|  |  |  |  |'.scan(/  /)[randam_number].gsub(  , ---)
