class EventInvitationsController < ApplicationController
  def update
    event_invitation = EventInvitation.find(params[:id])
    event_invitation.update(
      decision: params[:decision]
    )
    redirect_to '/events'
  end
end
