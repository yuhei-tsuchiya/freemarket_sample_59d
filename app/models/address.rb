class Address < ApplicationRecord
  belongs_to :user, optional: true

  # step3入力項目
  validates :zip_code,                presence: true, on: :validates_step3
  validates :prefecture_id,           presence: true, on: :validates_step3
  validates :jusho_shikuchoson,       presence: true, on: :validates_step3
  validates :jusho_banchi,            presence: true, on: :validates_step3
end
