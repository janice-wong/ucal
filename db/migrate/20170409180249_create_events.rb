class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :start_date
      t.string :end_date
      t.string :start_time
      t.string :end_time
      t.integer :duration
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
