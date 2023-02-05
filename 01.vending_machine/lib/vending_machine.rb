# frozen_string_literal: true

class VendingMachine
  PERMITTED_MONEY = [10, 50, 100, 500, 1000].freeze

  attr_reader :total, :sale_amount

  def initialize
    @total = 0
    @stock = [
      *5.times.map { Drink.new(120, 'coke') },
      *5.times.map { Drink.new(200, 'red_bull') },
      *5.times.map { Drink.new(100, 'water') }
    ]
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

  def purchasable?(drink)
    if @total >= drink.price && quantity(drink) >= 1
      true
    else
      false
    end
  end

  def purchase(drink)
    if purchasable?(drink)
      @total -= drink.price
      @sale_amount += drink.price
      delete_drink_index = @stock.index{ _1.name == drink.name }
      @stock.delete_at(delete_drink_index)
    end
  end

  def purchase_list
    current_stock.map do |drink|
      drink[:name] if drink[:quantity] > 0 && drink[:price] > @total
    end
  end

  def current_stock
    # [{name: 'coke', price: 120, quantity: 5}, {name: 'redbull', price: 120, quantity: 5}]
    uniq_stock = @stock.uniq(&:name)
    uniq_stock.each.map do |drink|
      {name: drink.name, price: drink.price, quantity: quantity(drink)}
    end
  end

  private

  def quantity(drink)
    @stock.count do |stock_drink|
      stock_drink.name == drink.name
    end
  end
end
