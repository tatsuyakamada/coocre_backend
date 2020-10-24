class CreateDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :dishes do |t|
      t.string :name, null: false
      t.integer :genre

      t.timestamps
    end
  end
end
