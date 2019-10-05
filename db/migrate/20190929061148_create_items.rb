class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string      :name,            null: false
      t.integer     :price,           null: false
      t.integer     :good,            null: false
      t.integer     :torihiki_info,   null: false
      t.integer     :product_state,   null: false
      t.text        :description,     null: false
      t.integer     :shipping_days,   null: false
      t.integer     :user_id,         null: false, foreign_key: true
      # t.integer     :category_id,     null: false, foreign_key: true
      # t.integer     :size_id,         null: false, foreign_key: true
      # t.integer     :burden_id,       null: false, foreign_key: true
      t.integer     :prefecture_id,   null: false, foreign_key:
      t.timestamps
    end
  end
end
