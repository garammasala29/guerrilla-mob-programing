# frozen_string_literal: true

class VendingMachine
  PERMITTED_MONEY = [10, 50, 100, 500, 1000].freeze

  attr_reader :total, :sale_amount, :stock

  def initialize
    @total = 0
    coke = Drink.new(name: :coke)
    @stock = {coke.name => Array.new(5, coke)}
    @sale_amount = 0
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

  def current_stock
    # [{name: 'coke', price: 120, quantity: 5}, {name: 'redbull', price: 120, quantity: 5}]
    @stock.map do |name, drinks|
      {name: name, price: Drink.price(name), quantity: drinks.size}
    end
  end

  def purchasable?(name)
    if @total >= Drink.price(name) && @stock[name].size >= 1
      true
    else
      false
    end
  end

  def purchase(name)
    if purchasable?(name)
      @total -= Drink.price(name)
      @sale_amount += Drink.price(name)
      @stock[name].pop
    end
  end
end
