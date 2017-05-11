class GroupInvitationsController < ApplicationController
  def accept
    @group_invitation = GroupInvitation.find(params[:id])
    @group_invitation.update(
      decision: "Accept"
    )
    redirect_to '/groups'
  end

  def decline
    @group_invitation = GroupInvitation.find(params[:id])
    @group_invitation.update(
      decision: "Decline"
    )
    if GroupInvitation.where(group_id: @group_invitation.group_id).count == 2
      @group_invitation.group.update(
        status: "cancelled"
      )
    end
    redirect_to '/groups'
  end
end
