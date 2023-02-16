# frozen_string_literal: true

class Amidakuji
  def self.generate(number)
    choices = ('A'..'Z').to_a
    choices[0, number].join('   ')
  end
end
