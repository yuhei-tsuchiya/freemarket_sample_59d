require 'rails_helper'

describe 'Item' do

  # 異常系
  describe '異常系' do  
    # name
    describe 'name' do
      # null
      describe 'presence: true' do
        it "nameのカラムが空の時エラー" do

          item = build(:item, name: "")
          item.valid?
          expect(item.errors[:name]).to include("can't be blank")

        end
      end
    end

    # price
    describe 'price' do
      # priceカラム-null
      describe 'presence: true' do 
        it "priceのカラムが空の時エラー" do

          item = build(:item, price: nil)
          item.valid?
          expect(item.errors[:price]).to include("can't be blank")

        end
      end

      # 値範囲外(9999999より大のエラー)
      describe 'numericality: over range' do
        it "priceのカラムが9999999より大のエラー" do

          item = build(:item, price: 10000000)
          item.valid?
          expect(item.errors[:price]).to include("must be less than or equal to 9999999")

        end
      end

      # 値範囲外(300未満)
      describe 'numericality: under range' do
        it "priceのカラムが300未満のエラー" do

          item = build(:item, price: 299)
          item.valid?
          expect(item.errors[:price]).to include("must be greater than or equal to 300")

        end
      end
    end

    # torihiki_info
    describe 'torihiki_info' do
      # null
      describe 'presence: true' do
        it "torihiki_infoのカラムが空の時エラー" do
          item = build(:item, torihiki_info: "")
          item.valid?
          expect(item.errors[:torihiki_info]).to include("can't be blank")
        end
      end

      # 値範囲
      describe 'numericality: over range' do
        it "torihiki_infoのカラムが2より大のエラー" do

          item = build(:item, torihiki_info: 3)
          item.valid?
          expect(item.errors[:torihiki_info]).to include("must be less than or equal to 2")

        end
      end
    end

    # product_state
    describe 'product_state' do
      # null
      describe 'presence: true' do
        it "product_stateのカラムが空の時エラー" do
          item = build(:item, product_state: "")
          item.valid?
          expect(item.errors[:product_state]).to include("can't be blank")
        end
      end

      # 値範囲
      describe 'numericality: over range' do
        it "product_stateのカラムが6より大のエラー" do

          item = build(:item, product_state: 7)
          item.valid?
          expect(item.errors[:product_state]).to include("must be less than or equal to 6")

        end
      end
    end

    # description
    describe 'description' do
      # null
      describe 'presence: true' do
        it "descriptionのカラムが空の時エラー" do
          item = build(:item, description: "")
          item.valid?
          expect(item.errors[:description]).to include("can't be blank")
        end
      end
    end

    # shipping_days
    describe 'shipping_days' do
      # null
      describe 'presence: true' do
        it "shipping_daysのカラムが空の時エラー" do
          item = build(:item, shipping_days: "")
          item.valid?
          expect(item.errors[:shipping_days]).to include("can't be blank")
        end
      end

      # 値範囲外(2より大のエラー)
      describe 'numericality: over range' do
        it "shipping_daysのカラムが2より大のエラー" do

          item = build(:item, shipping_days: 3)
          item.valid?
          expect(item.errors[:shipping_days]).to include("must be less than or equal to 2")

        end
      end
    end

    # user_id
    describe 'user_id' do
      # null
      describe 'presence: true' do
        it "user_idのカラムが空の時エラー" do
          item = build(:item, user_id: "")
          item.valid?
          expect(item.errors[:user_id]).to include("can't be blank")
        end
      end
    end

    # prefecture_id
    describe 'prefecture_id' do
      # null
      describe 'presence: true' do
        it "prefecture_idのカラムが空の時エラー" do
          item = build(:item, prefecture_id: "")
          item.valid?
          expect(item.errors[:prefecture_id]).to include("can't be blank")
        end
      end
      # 値範囲
      describe 'numericality: { less_than_or_equal_to: 48 }' do
        it "prefecture_idのidが48以下の値でなくては保存されないエラー" do
          item = build(:item, prefecture_id: 49)
          item.valid?
          expect(item.errors[:prefecture_id]).to include("must be less than or equal to 48")
        end
      end
    end

    # category_id
    describe 'category_id' do
      # null
      describe 'presence: true' do
        it "category_idのカラムが空の時エラー" do
          item = build(:item, category_id: nil)
          item.valid?
          expect(item.errors[:category_id]).to include("can't be blank")
        end
      end
      # 値範囲
      describe 'numericality: { less_than_or_equal_to: 1326 }' do
        it "category_idのidが1326以下の値でなくては保存されないエラー" do
          item = build(:item, category_id: 1327)
          item.valid?
          expect(item.errors[:category_id]).to include("must be less than or equal to 1326")
        end
      end
    end

    # size_id
    describe 'size_id' do
      # 値範囲
      describe 'numericality: { less_than_or_equal_to: 66 }' do
        it "size_idのidが66以下の値でなくては保存されないエラー" do
          item = build(:item, size_id: 67)
          item.valid?
          expect(item.errors[:size_id]).to include("must be less than or equal to 66")
        end
      end
    end

    # burden_id
    describe 'burden_id' do
      # null
      describe 'presence: true' do
        it "burden_idのカラムが空の時エラー" do
          item = build(:item, burden_id: nil)
          item.valid?
          expect(item.errors[:burden_id]).to include("can't be blank")
        end
      end
      # 値範囲
      describe 'numericality: { less_than_or_equal_to: 14 }' do
        it "burden_idのidが14以下の値でなくては保存されないエラー" do
          item = build(:item, burden_id: 15)
          item.valid?
          expect(item.errors[:burden_id]).to include("must be less than or equal to 14")
        end
      end
    end

    # brand_id
    describe 'brand_id' do
      # 値範囲
      describe 'numericality: { less_than_or_equal_to: 10102 }' do
        it "brand_idのidが10102以下の値でなくては保存されないエラー" do
          item = build(:item, brand_id: 10103)
          item.valid?
          expect(item.errors[:brand_id]).to include("must be less than or equal to 10102")
        end
      end
    end

    # アソシエーション-image
    describe 'has_many-image' do
      # 必須
      describe 'associated: true, presence: true' do
        it "アソシエーション-imageが空の時エラー" do
          item = build(:item)
          item.images = []
          item.valid?
          expect(item.errors[:images]).to include("can't be blank")
        end
      end
    end
  
  end
end