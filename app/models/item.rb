class Item < ApplicationRecord
  has_many :images
  has_many :comments
  belongs_to :user
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :burden
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  # torihiki_info、shipping_days、product_stateを文字列に変換するメソッドを定義
  def display_torihiki_info
    torihiki_info_list = ["出品中", "取引中", "売却済"]
    return torihiki_info_list[self.torihiki_info]
  end

  def display_product_state
    product_state_list = ["新品", "未使用", "傷なし", "やや傷あり", "やや傷汚れ", "傷汚れ", "状態悪し"]
    return product_state_list[self.product_state]
  end

  def display_shipping_days
    shipping_days_list = ["1~2日", "2~3日", "4~7日"]
    return shipping_days_list[self.shipping_days]
  end

end
