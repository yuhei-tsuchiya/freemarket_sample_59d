require 'rails_helper'

describe 'presence: true' do
  it "imageのカラムが空の時エラー" do
    image = build(:image, image: "")
    image.valid?
    expect(image.errors[:image]).to include("can't be blank")
  end
end