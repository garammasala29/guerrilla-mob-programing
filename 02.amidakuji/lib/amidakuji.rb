# frozen_string_literal: true
require 'byebug'

class Amidakuji
  def self.generate(number)
    self.new.generate(number)
  end

  def generate(number)
    alphabets = ('A'..'Z').to_a
    choices = [alphabets[0, number].join('   ')]
    lines = choices + vertical_lines(number) + hit_mark(number)
    lines.join("\n")
  end

  def vertical_lines(number)
    Array.new(number * 2, '|   |   |   |   |')
  end

  def hit_mark(number)
    line = Array.new(number - 1, '   ')
    line << '@   '
    [line.shuffle.join]
  end
end

# ['A   B   C   D   E', '|  |  |  |  |', '|  |  |  |  |', '|  |  |  |  |']
# '|  |  |  |  |'.scan(/  /)[randam_number].gsub(  , ---)
