require 'rails_helper'

describe User do
  describe '#create' do

    # step1
    # 1. nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a nickname, email, password, password_confirmation, lastname_kanji, firstname_kanji, lastname_kana, firstname_kana, birthday" do
      user = build(:user)
      expect(user).to be_valid
    end

    # 2. nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?(:validates_step1)
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # 3. emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?(:validates_step1)
      expect(user.errors[:email]).to include("can't be blank")
    end

    # 4. passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?(:validates_step1)
      expect(user.errors[:password]).to include("can't be blank")
    end

    # 5. passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?(:validates_step1)
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # # 6. nicknameが7文字以上であれば登録できないこと
    # it "is invalid with a nickname that has more than 7 characters " do
    #   user = build(:user, nickname: "aaaaaaaa")
    #   user.valid?
    #   expect(user.errors[:nickname][0]).to include("is too long")
    # end

    # # 7. nicknameが6文字以下では登録できること
    # it "is valid with a nickname that has less than 6 characters " do
    #   user = build(:user, nickname: "aaaaaa")
    #   expect(user).to be_valid
    # end

    # 8. 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?(:validates_step1)
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # 9. passwordが6文字以上であれば登録できること
    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?(:validates_step1)
      expect(user).to be_valid
    end

    # 10. passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "123456", password_confirmation: "123456")
      user.valid?(:validates_step1)
      expect(user.errors[:password][0]).to include("is too short")
    end

    # お名前(全角)・姓が空では登録できないこと
    it "is invalid without お名前(全角)・姓" do
      user = build(:user, lastname_kanji: nil)
      user.valid?(:validates_step1)
      expect(user.errors[:lastname_kanji]).to include("can't be blank")
    end
        
    # お名前(全角)・名が空では登録できないこと
    it "is invalid without お名前(全角)・名" do
      user = build(:user, firstname_kanji: nil)
      user.valid?(:validates_step1)
      expect(user.errors[:firstname_kanji]).to include("can't be blank")
    end

    # お名前カナ(全角) 姓が空では登録できないこと
    it "is invalid without お名前カナ(全角) 姓" do
      user = build(:user, lastname_kana: nil)
      user.valid?(:validates_step1)
      expect(user.errors[:lastname_kana]).to include("can't be blank")
    end

    # お名前カナ(全角) 名が空では登録できないこと
    it "is invalid without お名前カナ(全角) 名" do
      user = build(:user, firstname_kana: nil)
      user.valid?(:validates_step1)
      expect(user.errors[:firstname_kana]).to include("can't be blank")
    end

    # birthdayが空では登録できないこと
    it "is invalid without birthday" do
      user = build(:user, birthday: nil)
      user.valid?(:validates_step1)
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    # step2
    # 電話番号が空では登録できないこと
    it "is invalid without cellphone_number" do
      user = build(:user, cellphone_number: nil)
      user.valid?(:validates_step2)
      expect(user.errors[:cellphone_number]).to include("can't be blank")
    end

  end
end