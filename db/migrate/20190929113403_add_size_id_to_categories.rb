class AddSizeIdToCategories < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :size, foreign_key: true
    add_column :categories, :ancestry, :string, index: true
  end

  def down
    remove_index :categories, :ancestry
    remove_column :categories, :ancestry
  end
end
