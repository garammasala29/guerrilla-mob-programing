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

  # 名前を再考する
  def vertical_lines(number)
    blank_rows = Array.new((number * 2) - 1, ['   ','   ','   ','   '])
    rows = blank_rows << %w[--- --- --- ---]
    cols = rows.transpose.map { |col| col.shuffle }
    cols.transpose.map { |row| "|#{row.join('|')}|" }
  end

  def hit_mark(number)
    line = Array.new(number - 1, '   ')
    line << '@   '
    [line.shuffle.join]
    # 当たりが2列目の時にスペーサーがずれるのをどうにかする
  end
end

# ['A   B   C   D   E', '|  |  |  |  |', '|  |  |  |  |', '|  |  |  |  |']
# '|  |  |  |  |'.scan(/  /)[randam_number].gsub(  , ---)
