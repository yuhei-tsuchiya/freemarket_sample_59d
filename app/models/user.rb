class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]


  has_one :address
  has_many :items
  has_one :card
  accepts_nested_attributes_for :address

# SNS認証関係
  has_many :sns_credentials, dependent: :destroy

# item、transactとのアソシエーション
  has_many :buyer_transacts, class_name: 'Transact', foreign_key: 'buyer_id'
  has_many :seller_transacts, class_name: 'Transact', foreign_key: 'seller_id'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # user_info_input入力項目
  validates :nickname,                presence: true, length: {maximum: 20}, on: :validates_user_info_input
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, on: :validates_user_info_input
  validates :password,                presence: true, length: {minimum: 7, maximum: 128}, on: :validates_user_info_input
  validates :password_confirmation,   presence: true, length: {minimum: 7, maximum: 128}, on: :validates_user_info_input
  validates :lastname_kanji,          presence: true, on: :validates_user_info_input
  validates :firstname_kanji,         presence: true, on: :validates_user_info_input
  validates :lastname_kana,           presence: true, on: :validates_user_info_input
  validates :firstname_kana,          presence: true, on: :validates_user_info_input
  validates :birthday,                presence: true, on: :validates_user_info_input

  # phone_number_authentication入力項目
  validates :cellphone_number,        presence: true, on: :validates_phone_number_authentication

  # item、transactとのバリデーション
  validates :items, associated: true
  validates :buyer_transacts, associated: true
  validates :seller_transacts, associated: true


  # SNS認証関係
  @pass = Devise.friendly_token[0, 7]
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first
    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
        password: @pass,
        password_confirmation: @pass,
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user ,sns: sns}
  end

  def self.with_sns_data(auth, snscredential)
    # user = User.where(id: snscredential.user_id).first
    user = User.find_by(snscredential.user_id)
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
        password: @pass,
        password_confirmation: @pass,
      )
    end
    return {user: user}
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end

end
