require 'rails_helper'

describe 'numericality: { less_than: 67 }' do
  it "idが未満の値でなくては保存されない" do
    size= build(:size, id: 66)
    expect(size[:id]).to be < 67
  end
end