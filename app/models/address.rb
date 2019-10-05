class Address < ApplicationRecord
  belongs_to :user, optional: true

  # address_input入力項目
  validates :zip_code,                presence: true, on: :validates_address_input
  validates :prefecture_id,           presence: true, on: :validates_address_input
  validates :jusho_shikuchoson,       presence: true, on: :validates_address_input
  validates :jusho_banchi,            presence: true, on: :validates_address_input
end
