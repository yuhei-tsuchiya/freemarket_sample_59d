class RemoveUseridFromImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :user_id, :integer
  end
end
