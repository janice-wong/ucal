class RemoveGroupIdFromEventInvitations < ActiveRecord::Migration[5.0]
  def change
    remove_column :event_invitations, :group_id, :integer
  end
end
