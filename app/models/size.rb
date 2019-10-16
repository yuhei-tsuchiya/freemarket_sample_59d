class Size < ApplicationRecord
  has_many :categorys, dependent: :destroy
  has_ancestry

  validates :name, presence: true

end
