class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  has_ancestry
  belongs_to :size, optional: true

  validates :name, presence: true

end
