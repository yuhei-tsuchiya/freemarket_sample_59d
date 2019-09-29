class Size < ApplicationRecord
  has_many :categorys
  has_ancestry
end
