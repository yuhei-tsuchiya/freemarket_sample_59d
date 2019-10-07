require 'rails_helper'

describe 'Category' do

  # 異常系
  describe '異常系' do
    # id
    describe 'id' do
      # 値範囲
      describe 'numericality: { less_than_or_equal_to: 1326 }' do
        it "idが1326以下の値でなくては保存されないエラー" do
          category = build(:category, id: 1327)
          category.valid?
          expect(category.errors[:id]).to include("must be less than or equal to 1326")
        end
      end
    end
    # name
    describe 'name' do
      # 値範囲
      describe 'presence: true' do
        it "nameが空の時エラー" do
          category = build(:category, name: nil)
          category.valid?
          expect(category.errors[:name]).to include("can't be blank")
        end
      end
    end
  end
end