class CreateBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :blocks do |t|
      t.integer :user_id
      t.datetime :start

      t.timestamps
    end
  end
end
