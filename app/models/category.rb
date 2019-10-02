class Category < ApplicationRecord
  has_many :items
  has_ancestry
  belongs_to :size, optional: true

  validates :id, numericality: { less_than_or_equal_to: 1000 }
end
