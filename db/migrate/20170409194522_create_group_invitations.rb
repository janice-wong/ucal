class CreateGroupInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :group_invitations do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :mem_type
      t.string :decision

      t.timestamps
    end
  end
end
