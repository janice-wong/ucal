class EventInvitationsController < ApplicationController
  def update
    event_invitation = EventInvitation.find(params[:id])
    event_invitation.update(
      decision: params[:decision]
    )

    if event_invitation.decision == "Accept"
      min_duration = (event_invitation.event.end - event_invitation.event.start) / 60
      i = 0
      (min_duration / 15).to_i.times do
        Block.create(
          user_id: current_user.id,
          start: event_invitation.event.start + i
        )
        i += (15 * 60)
      end
    end
    
    redirect_to '/events'
  end
end
