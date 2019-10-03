class RemoveAddressidFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :address, foreign_key: true
  end
end
