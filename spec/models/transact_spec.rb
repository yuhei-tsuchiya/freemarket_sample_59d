require 'rails_helper'

describe 'Transact' do

  # 異常系
  describe '異常系' do
    # アソシエーション-seller_id
    describe 'seller_id' do
      # null
      describe 'presence: true' do
        it "seller_idが空の時エラー" do
          transact = build(:transact, seller: nil)
          transact.valid?
          expect(transact.errors[:seller]).to include("can't be blank")
        end
      end
    end
    # アソシエーション-item_id
    describe 'item_id' do
      # null
      describe 'presence: true' do
        it "item_idが空の時エラー" do
          transact = build(:transact, item: nil)
          transact.valid?
          expect(transact.errors[:item]).to include("can't be blank")
        end
      end
    end
  end
end