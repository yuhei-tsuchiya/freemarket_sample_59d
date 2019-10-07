require 'rails_helper'

describe 'Size' do

  # 異常系
  describe '異常系' do
    # id
    describe 'id' do
      # 値範囲
      describe 'numericality: { less_than_or_equal_to: 66 }' do
        it "idが66未満の値でなくては保存されないエラー" do
          size= build(:size, id: 67)
          size.valid?
          expect(size.errors[:id]).to include("must be less than or equal to 66")
        end
      end
    end
    # name
    describe 'name' do
      # null
      describe 'presence: true' do
        it "nameのカラムが空の時エラー" do
  
          size = build(:size, name: "")
          size.valid?
          expect(size.errors[:name]).to include("can't be blank")

        end
      end
    end
  end
end