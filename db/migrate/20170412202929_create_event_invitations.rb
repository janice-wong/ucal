class CreateEventInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :event_invitations do |t|
      t.integer :event_id
      t.integer :group_id
      t.integer :user_id
      t.string :mem_type
      t.string :decision

      t.timestamps
    end
  end
end
