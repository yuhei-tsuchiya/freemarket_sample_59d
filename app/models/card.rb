class Card < ApplicationRecord
  belongs_to :user,dependent: :destroy
end
