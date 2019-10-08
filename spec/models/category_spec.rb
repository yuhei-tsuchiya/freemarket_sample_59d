require 'rails_helper'

describe 'Category' do

  # 異常系
  describe '異常系' do
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