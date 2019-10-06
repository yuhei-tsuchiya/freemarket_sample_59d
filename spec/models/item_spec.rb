require 'rails_helper'

# FactoryBot.define do
#   factory :item do
#     name                  {"test"}
#     price                 {1000}
#     good                  {2}
#     torihiki_info         {2}
#     product_state         {1}
#     description           {"test"}
#     shipping_days         {2}
#     user_id               {1}
#     prefecture_id         {3}
#     category_id           {160}
#     size_id               {10}
#     burden_id             {4}
#   end
# end


describe 'nameカラム' do
  it "nameのカラムが空の時エラー" do

    item = Item.create(name: "", price: 1000, good: 2, torihiki_info: 2, product_state: 1, description: "test desu", shipping_days: 2, user_id: 1, prefecture_id: 3, category_id: 160, size_id: 10, burden_id: 4)
    item.valid?
    expect(item.errors[:name]).to include("can't be blank")

  end
end

describe 'presence: true' do
  it "priceのカラムが空の時エラー" do

    item = Item.create(name: "text", price: nil, good: 2, torihiki_info: 2, product_state: 1, description: "test desu", shipping_days: 2, user_id: 1, prefecture_id: 3, category_id: 160, size_id: 10, burden_id: 4)
    item.valid?
    expect(item.errors[:price]).to include("can't be blank")

  end
end

describe 'presence: true' do
  it "product_stateのカラムが空の時エラー" do
    item = build(:item, product_state: "")
    item.valid?
    expect(item.errors[:product_state]).to include("can't be blank")
  end
end


describe 'presence: true' do
  it "descriptionのカラムが空の時エラー" do
    item = build(:item, description: "")
    item.valid?
    expect(item.errors[:description]).to include("can't be blank")
  end
end

describe 'presence: true' do
  it "shipping_daysのカラムが空の時エラー" do
    item = build(:item, shipping_days: "")
    item.valid?
    expect(item.errors[:shipping_days]).to include("can't be blank")
  end
end


describe 'presence: true' do
  it "user_idのカラムが空の時エラー" do
    item = build(:item, user_id: "")
    item.valid?
    expect(item.errors[:user_id]).to include("can't be blank")
  end
end

describe 'prefecture_id' do
  describe 'presence: true' do
    it "prefecture_idのカラムが空ならtrue" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end
  end
  describe 'numericality: { less_than: 48 }' do
    it "prefecture_idのidが49未満の値でなくては保存されない" do
      item = build(:item, prefecture_id: 48)
      expect(item[:prefecture_id]).to be < 49
    end
  end
end

describe 'presence: true' do
  it "category_idのカラムが空ならtrue" do
    item = build(:item, category_id: nil)
    item.valid?
    expect(item.errors[:category_id]).to include("can't be blank")
  end
end

describe 'presence: true' do
  it "size_idのカラムが空ならtrue" do
    user = create(:user)
    category = create(:category)
    burden = create(:burden)
    item = build(:item, size_id: nil)
    expect(item).to be_valid
  end
end

describe 'presence: true' do
  it "burden_idのカラムが空ならtrue" do
    item = build(:item, burden_id: nil)
    item.valid?
    expect(item.errors[:burden_id]).to include("can't be blank")
  end
end