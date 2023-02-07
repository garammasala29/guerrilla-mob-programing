# frozen_string_literal: true

class VendingMachine
  PERMITTED_MONEY = [10, 50, 100, 500, 1000].freeze

  attr_reader :total, :sale_amount, :stock

  def initialize
    @total = 0
    coke = Drink.new(:coke)
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

  def store(name, quantity)
    drink = Drink.new(name)
    drinks = Array.new(quantity, drink)
    if @stock[name]
      @stock[name].push(*drinks)
    else
      @stock[name] = drinks
    end
  end
  def current_stock
    @stock.map do |name, drinks|
      {name: name, price: Drink.price(name), quantity: drinks.size}
    end
  end

  def purchasable_stock
    @stock.keys.select {purchasable?(_1)}.sort
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
      puts "残額：#{@total}円"
    end
  end
end
