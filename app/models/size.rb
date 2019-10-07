class Size < ApplicationRecord
  has_many :categorys
  has_ancestry

  validates :id, numericality: { less_than_or_equal_to: 66 }
  validates :name, presence: true
end
