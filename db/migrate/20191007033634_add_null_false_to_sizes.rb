class AddNullFalseToSizes < ActiveRecord::Migration[5.2]
  def change
    change_column :sizes, :name, :string, null: false
    change_column :categories, :name, :string, null: false
    change_column :brands, :name, :string, null: false
  end
end
