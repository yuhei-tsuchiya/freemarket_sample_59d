class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string, null: false, unique: true
    change_column :users, :email, :string, null: false, unique: true
    add_column :users, :lastname_kanji, :string, null: false
    add_column :users, :firstname_kanji, :string, null: false
    add_column :users, :lastname_kana, :string, null: false
    add_column :users, :firstname_kana, :string, null: false
    add_column :users, :birthday, :integer, null: false
    add_column :users, :cellphone_number, :string, null: false
    add_column :users, :phone_credential, :integer
    # add_reference :users, :address, foreign_key: true
    add_column :users, :introduction, :text
  end
end
