# frozen_string_literal: true
require 'byebug'

class Amidakuji
  def self.generate(number)
    self.new.generate(number)
  end

  def generate(number)
    alphabets = ('A'..'Z').to_a
    choices = [alphabets[0, number].join('   ')]
    lines = choices + ladder(number) + hit_mark(number)
    lines.join("\n")
  end

  def ladder(number)
    row = Array.new(number - 2, '   ')
    row << '---'
    wip_rows = number.times.map { row.shuffle }
    rows = connect_vertical_lines(wip_rows)
    spacers = Array.new(number - 1, '   ')
    rows.push(spacers).unshift(spacers).map { |row| "|#{row.join('|')}|" }
  end

  def connect_vertical_lines(wip_rows)
    shadow_cols = wip_rows.transpose.map do |col|
      if col.include?('---')
        Array.new(col.count, '   ')
      else
        Array.new(col.count - 1, '   ').push('---').shuffle
      end
    end
    shadow_rows = shadow_cols.transpose
    wip_rows.zip(shadow_rows).flatten(1)
  end
  def hit_mark(number)
    line = Array.new(number - 1, '    ')
    line << '@   '
    [line.shuffle.join]
  end
end
