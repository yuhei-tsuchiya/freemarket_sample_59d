require 'rails_helper'

describe 'Burden' do

  # 異常系
  describe '異常系' do
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