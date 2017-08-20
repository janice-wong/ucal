class RemoveNotificationsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :notifications
  end

  def down
    ActiveRecord::IrreversibleMigration
  end
end
