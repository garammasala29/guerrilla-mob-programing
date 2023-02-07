# frozen_string_literal: true

class Drink
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.price(name)
    case name
    when :coke
      120
    when :water
      100
    when :redbull
      200
    else
      '指定されたドリンクの料金はありません'
    end
  end
end
