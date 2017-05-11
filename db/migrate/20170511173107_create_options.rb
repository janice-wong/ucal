class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.datetime :start
      t.datetime :end
      t.integer :event_id
      t.integer :user_id
      t.string :vote

      t.timestamps
    end
  end
end
