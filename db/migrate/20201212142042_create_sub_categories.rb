class CreateSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_categories do |t|
      t.references :category
      t.string :name, null: false

      t.timestamps
    end
  end
end
