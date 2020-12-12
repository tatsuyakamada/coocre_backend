class CreateDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :dishes do |t|
      t.string :name, null: false
      t.integer :genre, null: false
      t.integer :category, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
