class AddBranditToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :have_brand, :boolean, default: false, null: false
  end
end
