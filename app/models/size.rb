class Size < ApplicationRecord
  has_many :categorys
  has_ancestry

  validates :id, numericality: { less_than: 67 }
end
