class GroupInvitationsController < ApplicationController
  def update
    @group_invitation = GroupInvitation.find(params[:id])
    @group_invitation.update(
      decision: params[:decision]
    )
    if @group_invitation.decision == "Decline" && GroupInvitation.where(group_id: @group_invitation.group_id)
      @group_invitation.group.update(
        status: "cancelled"
      )
    end
    redirect_to '/groups'
  end
end
