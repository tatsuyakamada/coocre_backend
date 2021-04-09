class CreateDishStuffs < ActiveRecord::Migration[6.0]
  def change
    create_table :dish_stuffs do |t|
      t.references :dish
      t.references :stuff
      t.integer :category

      t.timestamps
    end
  end
end
