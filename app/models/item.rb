class Item < ApplicationRecord
  has_many :images
  has_many :comments
  belongs_to :user
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :burden

#バリデーション
  validates :name, presence: true
  validates :price, presence: true
  validates :torihiki_info, presence: true
  validates :product_state, presence: true
  validates :description, presence: true
  validates :shipping_days, presence: true
  validates :user_id, presence: true
  validates :prefecture_id, {presence: true, numericality: { less_than: 48 }}
  validates :category_id, presence: true
  validates :size_id, presence: true
  1validates :burden_id, presence: true


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  @@torihiki_info_list = ["出品中", "取引中", "売却済"]
  @@product_state_list = ["新品", "未使用", "傷なし", "やや傷あり", "やや傷汚れ", "傷汚れ", "状態悪し"]
  @@shipping_days_list = ["1~2日", "2~3日", "4~7日"]

  # orihiki_info、shipping_days、product_stateの配列を返すメソッドを定義
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
