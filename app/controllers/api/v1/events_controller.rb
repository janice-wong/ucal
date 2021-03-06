class Api::V1::EventsController < ApplicationController
  def index
    @accepted_events = []
    if current_user
      EventInvitation.where(user_id: current_user.id).each do |invitation|
        if invitation.decision == "Accept" && Event.find(invitation.event_id).status == "sent"
          @accepted_events << invitation.event
        end
      end
    end
    render 'index.json.jbuilder'
  end

  def show
    @event = Event.find(params[:id])
    render 'show.json.jbuilder'
  end

  def group_events
    users = []
    GroupInvitation.where(group_id: params[:group_id], decision: "Accept").each do |invitation|
      users << invitation.user
    end

    @invitations = []
    users.each do |user|
      EventInvitation.where(user_id: user.id, decision: "Accept"). each do |invite|
        if Event.find(invite.event_id).status == "sent"
          @invitations << invite
        end
      end
    end
    render 'group_events.json.jbuilder'
  end
end
