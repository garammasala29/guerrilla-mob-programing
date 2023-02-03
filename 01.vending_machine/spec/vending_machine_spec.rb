# frozen_string_literal: true

require_relative '../lib/vending_machine'

RSpec.describe VendingMachine do
  before do
    @vending_machine = VendingMachine.new
  end

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
