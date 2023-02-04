# frozen_string_literal: true

class Drink
  attr_reader :price, :name

  def initialize(price, name)
    @price = price
    @name = name
  end
end
