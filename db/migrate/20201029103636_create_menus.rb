class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.references :schedule
      t.references :dish
      t.integer :category
      t.text :memo

      t.timestamps
    end
  end
end
