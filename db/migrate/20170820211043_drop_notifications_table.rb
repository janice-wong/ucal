class DropNotificationsTable < ActiveRecord::Migration[5.0]
  def down
    drop_table :notifications
  end
end
