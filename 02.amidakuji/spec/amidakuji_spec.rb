# frozen_string_literal: true

require_relative '../lib/amidakuji'
require 'byebug'

RSpec.describe  Amidakuji do
  before do
    @lines = Amidakuji.generate(5).split(/\R/)
  end

  example "引数で渡した人数分の選択肢が表示される" do
    expect(@lines[0]).to eq 'A   B   C   D   E'
  end

  example "選択肢の下に縦棒が人数分の2倍の行数伸びている" do
    expect(@lines[1]).to eq '|   |   |   |   |'
    expect(@lines[10]).to eq '|   |   |   |   |'
  end

  example "最終行に当たりの記載が1つある" do
    expect(@lines[11].strip).to eq '@'
  end

  example "各縦棒の間に横棒が1本以上ある" do
    columns = @lines[1, 10].map do |line|
      line.split('|')
    end.transpose

    expect(columns[1]).to include '---'
    expect(columns[2]).to include '---'
    expect(columns[3]).to include '---'
    expect(columns[4]).to include '---'
  end

  example "1行に横棒が2つ以上存在しない" do
    expect(@lines[2].count('---')).to be < 2
  end
end
