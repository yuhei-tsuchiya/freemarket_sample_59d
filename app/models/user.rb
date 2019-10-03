class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  has_many :buyer_transacts, class_name: 'Transact', foreign_key: 'buyer_id'
  has_many :seller_transacts, class_name: 'Transact', foreign_key: 'seller_id'
end
