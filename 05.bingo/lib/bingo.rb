class Bingo
  def self.generate_card
    self.new.generate_card
  end

  def generate_card
    (header + numbers).join("\n")
  end

  private

  def header
    ['BINGO'.chars.map{ _1.rjust(2) }.join(' | ')]
  end

  CENTER_NUMBER = 2
  def numbers
    n = 0
    col = []
    5.times.each do |i|
      col << (n + 1..n + 15).to_a.map{ _1.to_s.rjust(2) }.sample(5)
      n += 15
    end

    col.transpose.map.with_index do |row, idx|
      row[CENTER_NUMBER] = '  ' if idx == CENTER_NUMBER
      row.join(' | ')
    end
  end
end
