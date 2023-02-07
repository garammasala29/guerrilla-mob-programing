# frozen_string_literal: true

require_relative '../lib/vending_machine'
require_relative '../lib/drink'
require 'byebug'

RSpec.describe VendingMachine do
  before do
    @vending_machine = VendingMachine.new
  end

  context 'お金の扱い' do
    example '自販機のインスタンスを作ることができる' do
      expect(@vending_machine).to be_truthy
    end

    example '投入金額の総額を返す' do
      @vending_machine.insert(100)
      @vending_machine.insert(50)
      expect(@vending_machine.total).to eq 150
    end

    example '払い戻し操作を行うと投入金額の総額が返ってくる' do
      expect(@vending_machine.insert(100)).to eq 0
      expect(@vending_machine.payback).to eq 100
      expect(@vending_machine.total).to eq 0
    end

    example '扱えない金種なら返却する' do
      expect(@vending_machine.insert(1)).to eq 1
      expect(@vending_machine.total).to eq 0
    end
  end

  context 'コーラを購入する' do
    example 'コーラの在庫の本数がわかる' do
      expect(@vending_machine.stock[:coke].size).to eq 5
    end

    example '在庫のドリンク情報がわかる' do
      expect(@vending_machine.current_stock).to eq([{ name: :coke, price: 120, quantity: 5 }])
    end

    example 'コーラを1本買うと在庫が1本減って売上が120円増える' do
      @vending_machine.insert(500)
      expect(@vending_machine.purchasable?(:coke)).to eq true

      @vending_machine.purchase(:coke)
      expect(@vending_machine.total).to eq 380
      expect(@vending_machine.sale_amount).to eq 120
      expect(@vending_machine.current_stock).to eq([{ name: :coke, price: 120, quantity: 4 }])
    end

    example '100円投入して水を購入すると投入金額（残額）が0円になっている' do
      @vending_machine.store(:water, 5)

      @vending_machine.insert(100)
      @vending_machine.purchase(:water)
      expect(@vending_machine.total).to eq 0
    end

    example 'コーラを1本買った後のおつりが返ってくる' do
      @vending_machine.insert(500)
      @vending_machine.purchase(:coke)

      expect(@vending_machine.payback).to eq 380
    end

    example '購入金額が足りない時は購入できず、在庫や売り上げも変わらない' do
      @vending_machine.insert(100)
      expect(@vending_machine.purchasable?(:coke)).to eq false

      @vending_machine.purchase(:coke)
      expect(@vending_machine.sale_amount).to eq 0
      expect(@vending_machine.current_stock).to eq([{ name: :coke, price: 120, quantity: 5 }])
    end

    example '在庫が足りない時は購入できず、在庫や売り上げも変わらない' do
      @vending_machine.insert(1000)
      5.times { @vending_machine.purchase(:coke) }
      @vending_machine.payback
      expect(@vending_machine.sale_amount).to eq 600
      expect(@vending_machine.stock[:coke].size).to eq 0

      @vending_machine.insert(500)
      expect(@vending_machine.purchasable?(:coke)).to eq false

      @vending_machine.purchase(:coke)
      expect(@vending_machine.sale_amount).to eq 600
      expect(@vending_machine.stock[:coke].size).to eq 0
    end

    example '飲み物の料金がわかる' do
      expect(Drink.price(:coke)).to eq 120
    end
  end

  context '在庫管理' do
    example '在庫に水5本を追加できる' do
      @vending_machine.store(:water, 5)
      expect(@vending_machine.stock[:water].size).to eq 5
    end

    example '在庫にコーラ3本を追加できる' do
      @vending_machine.store(:coke, 34)
      expect(@vending_machine.stock[:coke].size).to eq 39
    end

    example '投入金額、在庫の点で購入可能なドリンクのリストを取得できる' do
      @vending_machine.store(:water, 5)
      @vending_machine.store(:redbull, 5)

      @vending_machine.insert 100
      expect(@vending_machine.purchasable_stock).to eq([:water])
      @vending_machine.insert 100
      expect(@vending_machine.purchasable_stock).to eq([:coke, :redbull, :water])
    end
  end

  context 'Drink' do
    example '各ドリンクの価格を取得できる' do
      expect(Drink.price :coke).to eq 120
      expect(Drink.price :water).to eq 100
      expect(Drink.price :redbull).to eq 200
    end
  end
end
