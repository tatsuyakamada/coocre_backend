class AddIndexToDishName < ActiveRecord::Migration[6.0]
  def change
    add_index :dishes, :name, unique: true
  end
end
