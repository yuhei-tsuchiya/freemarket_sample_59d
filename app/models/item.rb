class Item < ApplicationRecord

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :user
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :brand, optional: true
  belongs_to :burden

  # いいね機能
  has_many :likes, dependent: :destroy
  def like_user(id)
    likes.find_by(user_id: id)
  end

  has_one :transact, dependent: :destroy
  accepts_nested_attributes_for :transact
  # has_many :comments  # コメント機能が実装できた際に有効化すること

  # null falseのバリデーション
  with_options presence: true do
    validates :name
    validates :price
    validates :torihiki_info
    validates :product_state
    validates :description
    validates :shipping_days
    validates :user_id
    validates :prefecture_id
    validates :category_id
    validates :burden_id
  end
  # 入力値範囲のバリデーション
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  validates :prefecture_id, numericality: { less_than_or_equal_to: 48 }
  validates :torihiki_info, numericality: { less_than_or_equal_to: 2 }
  validates :product_state, numericality: { less_than_or_equal_to: 6 }
  validates :shipping_days, numericality: { less_than_or_equal_to: 2 }
  validates :category_id, numericality: { less_than_or_equal_to: 1326 }
  validates :size_id, numericality: { less_than_or_equal_to: 66 }, allow_blank: true
  validates :brand_id, numericality: { less_than_or_equal_to: 10102 }, allow_blank: true
  validates :burden_id, numericality: { less_than_or_equal_to: 14 }

  # アソシエーションのバリデーション
  validates :images, associated: true, presence: true
  validates :transact, associated: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture


  @@torihiki_info_list = ["出品中", "取引中", "売却済"]
  @@product_state_list = ["新品", "未使用", "傷なし", "やや傷あり", "やや傷汚れ", "傷汚れ", "状態悪し"]
  @@shipping_days_list = ["1~2日", "2~3日", "4~7日"]

  # torihiki_info、shipping_days、product_stateの配列を返すメソッドを定義
  def torihiki_info_list
    @@torihiki_info_list
  end

  def product_state_list
    @@product_state_list
  end

  def shipping_days_list
    @@shipping_days_list
  end

  # torihiki_info、shipping_days、product_stateを文字列に変換するメソッドを定義
  def display_torihiki_info
    return self.torihiki_info_list[self.torihiki_info]
  end

  def display_product_state
    return self.product_state_list[self.product_state]
  end

  def display_shipping_days
    return self.shipping_days_list[self.shipping_days]
  end

end
