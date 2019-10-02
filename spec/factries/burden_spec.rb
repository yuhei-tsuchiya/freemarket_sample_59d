require 'rails_helper'

FactoryBot.define do

  factory :burden do
    name                  {"ゆうメール"}

  end
end

describe 'numericality: { less_than: 15 }' do
  it "idが15未満の値でなくては保存されない" do
    burden = build(:burden, id: 14)
    expect(burden[:id]).to be < 15
  end
end