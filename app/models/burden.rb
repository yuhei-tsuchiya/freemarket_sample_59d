class Burden < ApplicationRecord
  has_many :items
  has_ancestry

  validates :id, numericality: { less_than_or_equal_to: 14 }
  validates :name, presence: true
end
