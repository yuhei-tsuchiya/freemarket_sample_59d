class CreateTestimages < ActiveRecord::Migration[5.2]
  def change
    create_table :testimages do |t|
      t.string  :image
      t.timestamps
    end
  end
end
