class Item < ApplicationRecord
  has_many :images
  has_many :comments
  belongs_to :user
  belongs_to :category
  belongs_to :size
  belongs_to :burden
  belongs_to_active_hash :prefecture
end
