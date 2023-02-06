# frozen_string_literal: true

class Drink
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def self.price(name)
    case name
    when :coke
      120
    end
  end
end
