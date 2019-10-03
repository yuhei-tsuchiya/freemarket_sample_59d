class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  accepts_nested_attributes_for :address

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # step1入力項目
  validates :nickname,                presence: true, length: {maximum: 20}, on: :validates_step1
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, on: :validates_step1
  validates :password,                presence: true, length: {minimum: 7, maximum: 128}, on: :validates_step1
  validates :password_confirmation,   presence: true, length: {minimum: 7, maximum: 128}, on: :validates_step1
  validates :lastname_kanji,          presence: true, on: :validates_step1
  validates :firstname_kanji,         presence: true, on: :validates_step1
  validates :lastname_kana,           presence: true, on: :validates_step1
  validates :firstname_kana,          presence: true, on: :validates_step1
  validates :birthday,                presence: true, on: :validates_step1
  
  # step2入力項目
  validates :cellphone_number,        presence: true, on: :validates_step2
end
