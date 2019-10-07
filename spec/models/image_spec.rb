require 'rails_helper'

describe 'Image' do

  # 異常系
  describe '異常系' do
    # image
    describe 'image' do
      describe 'presence: true' do
        it "imageのカラムが空の時エラー" do
          image = build(:image, image: "")
          image.valid?
          expect(image.errors[:image]).to include("can't be blank")
        end
      end
    end
    # アソシエーション-item
    describe 'belongs_to item' do
      describe 'presence: true' do
        it "itemが空の時エラー" do
          image = build(:image, item: nil)
          image.valid?
          expect(image.errors[:item]).to include("can't be blank")
        end
      end
    end
  end
end