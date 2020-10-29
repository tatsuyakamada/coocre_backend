class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.date :date, null: false
      t.integer :category, null: false
      t.text :memo

      t.timestamps
    end
  end
end
