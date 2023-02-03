# frozen_string_literal: true

class VendingMachine
  PERMITTED_MONEY = [10, 50, 100, 500, 1000].freeze

  attr_reader :total

  def initialize
    @total = 0
  end

  def insert(money)
    if PERMITTED_MONEY.include?(money)
      @total += money
      0
    else
      money
    end
  end

  def payback
    change = @total
    @total = 0
    change
  end
end
