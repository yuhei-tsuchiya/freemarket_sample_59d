require 'rails_helper'

FactoryBot.define do

  factory :size do
  name                  {"27cm"}

  end
end

describe 'numericality: { less_than: 67 }' do
  it "idが未満の値でなくては保存されない" do
    size= build(:size, id: 66)
    expect(size[:id]).to be < 67
  end
end