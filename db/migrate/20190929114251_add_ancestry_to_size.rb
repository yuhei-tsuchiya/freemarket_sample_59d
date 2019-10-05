class AddAncestryToSize < ActiveRecord::Migration[5.2]
  def change
    add_column :sizes, :ancestry, :string, index: true
  end
end
