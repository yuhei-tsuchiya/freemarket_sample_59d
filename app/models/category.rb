class Category < ApplicationRecord
  has_many :items
  has_ancestry
  belongs_to :size, optional: true
end