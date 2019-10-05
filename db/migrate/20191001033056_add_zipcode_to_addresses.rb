class AddZipcodeToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :zip_code, :string, null: false
  end
end
