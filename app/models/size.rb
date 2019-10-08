class Size < ApplicationRecord
  has_many :categorys
  has_ancestry

  validates :name, presence: true

end
