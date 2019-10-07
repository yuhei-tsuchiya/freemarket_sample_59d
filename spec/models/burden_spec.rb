require 'rails_helper'

describe 'Burden' do

  # 異常系
  describe '異常系' do
    # id
    describe 'id' do
      # 値範囲
      describe 'numericality: { less_than_or_equal_to: 14 }' do
        it "idが14以下の値でなくては保存されないエラー" do
          burden = build(:burden, id: 15)
          burden.valid?
          expect(burden.errors[:id]).to include("must be less than or equal to 14")
        end
      end
    end
    # name
    describe 'name' do
      # 値範囲
      describe 'presence: true' do
        it "nameが空の時エラー" do
          burden = build(:burden, name: nil)
          burden.valid?
          expect(burden.errors[:name]).to include("can't be blank")
        end
      end
    end
  end
end