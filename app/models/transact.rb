class Transact < ApplicationRecord
  belongs_to :item
  belongs_to :buyer,  class_name: 'User', foreign_key: 'buyer_id', optional:true
  belongs_to :seller, class_name: 'User', foreign_key:  'seller_id'

  # バリデーション
  validates :item, presence: true
  validates :seller, presence: true

end