class CreateStuffs < ActiveRecord::Migration[6.0]
  def change
    create_table :stuffs do |t|
      t.references :sub_category
      t.string :name, null: false, unique: true

      t.timestamps

      t.index :name, unique: true
    end
  end
end
