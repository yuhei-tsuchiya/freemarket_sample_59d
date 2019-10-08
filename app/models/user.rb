class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  has_many :items

  accepts_nested_attributes_for :address

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

end
