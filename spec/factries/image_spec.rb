require 'rails_helper'

FactoryBot.define do

  factory :image do
    image              {"https://stickershop.line-scdn.net/stickershop/v1/product/11581/LINEStorePC/main.png;compress=true"}

  end
end


describe 'presence: true' do
  it "imageのカラムが空の時エラー" do
    image = build(:image, image: "")
    image.valid?
    expect(image.errors[:image]).to include("can't be blank")
  end
end