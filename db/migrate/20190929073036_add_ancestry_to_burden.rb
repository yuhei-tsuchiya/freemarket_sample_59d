class AddAncestryToBurden < ActiveRecord::Migration[5.2]
  def change
    add_column :burdens, :ancestry, :string
    add_index :burdens, :ancestry
  end
end
