require 'rails_helper'

describe 'Size' do

  # 異常系
  describe '異常系' do
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