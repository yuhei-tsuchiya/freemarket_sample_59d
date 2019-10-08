class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :prefecture_id,      null: false, foreign_key: true
      t.string :jusho_shikuchoson,  null: false
      t.string :jusho_banchi,       null: false
      t.string :jusho_tatemono,     null: false
      t.string :phone_number

      t.timestamps
    end
  end
end
