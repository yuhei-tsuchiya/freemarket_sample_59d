class AddOptionToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :user_id, :bigint, foreign_key: true
  end
end
