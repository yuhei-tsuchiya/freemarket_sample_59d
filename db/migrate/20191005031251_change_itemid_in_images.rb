class ChangeItemidInImages < ActiveRecord::Migration[5.2]
  def change
    change_column :images, :item_id, :bigint, foreign_key: true
  end
end
