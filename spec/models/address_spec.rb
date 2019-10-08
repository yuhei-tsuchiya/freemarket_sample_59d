require 'rails_helper'

describe Address do
  describe '#create' do

    # step1
    # 1. nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a zip_code, prefecture_id, jusho_shikuchoson, jusho_banchi" do
      address = build(:address)
      expect(address).to be_valid
    end

    # 2. zip_codeが空では登録できないこと
    it "is invalid without a zip_code" do
      address = build(:address, zip_code: nil)
      address.valid?(:validates_step3)
      expect(address.errors[:zip_code]).to include("can't be blank")
    end

    # 3. prefecture_idが空では登録できないこと
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id: nil)
      address.valid?(:validates_step3)
      expect(address.errors[:prefecture_id]).to include("can't be blank")
    end

    # 4. jusho_shikuchosonが空では登録できないこと
    it "is invalid without a jusho_shikuchoson" do
      address = build(:address, jusho_shikuchoson: nil)
      address.valid?(:validates_step3)
      expect(address.errors[:jusho_shikuchoson]).to include("can't be blank")
    end

    # 5. jusho_banchiが空では登録できないこと
    it "is invalid without a jusho_banchi" do
      address = build(:address, jusho_banchi: nil)
      address.valid?(:validates_step3)
      expect(address.errors[:jusho_banchi]).to include("can't be blank")
    end
    
  end
end