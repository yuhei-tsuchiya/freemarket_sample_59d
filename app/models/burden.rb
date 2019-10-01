class Burden < ApplicationRecord
  has_many :items
  has_ancestry

  validates :id, numericality: { less_than: 15 }
end
