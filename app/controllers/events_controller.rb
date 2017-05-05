class EventsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @pending_events = []
    @accepted_events = []
    @tentative_events = []
    if current_user
      EventInvitation.where(user_id: current_user.id).each do |invitation|
        if invitation.decision == "pending" && Event.find(invitation.event_id).status != "cancelled"
          @pending_events << invitation.event
        elsif invitation.decision == "Accept" && Event.find(invitation.event_id).status != "cancelled"
          @accepted_events << invitation.event
        elsif invitation.decision == "Tentative" && Event.find(invitation.event_id).status != "cancelled"
          @tentative_events << invitation.event
        end
      end
    end
  end

  def new
    @groups = []
    User.find(current_user.id).group_invitations.where(decision: "Accept").each do |invitation|
      if Group.find(invitation.group_id).status == "active"
        @groups << Group.find(invitation.group_id).name
      end
    end
    render 'new.html.erb'
  end

  def create
    event = Event.create(
      name: params[:name],
      start: DateTime.new(
        params["start_date"]["date(1i)"].to_i,
        params["start_date"]["date(2i)"].to_i,
        params["start_date"]["date(3i)"].to_i,
        params["start_time"]["time(4i)"].to_i,
        params["start_time"]["time(5i)"].to_i
      ),
      end: DateTime.new(
        params["end_date"]["date(1i)"].to_i,
        params["end_date"]["date(2i)"].to_i,
        params["end_date"]["date(3i)"].to_i,
        params["end_time"]["time(4i)"].to_i,
        params["end_time"]["time(5i)"].to_i
      ),
      # duration: params[:duration],
      location: params[:location],
      status: "sent"
    )

    event_invite = EventInvitation.create(
      event_id: event.id,
      user_id: current_user.id,
      mem_type: "owner",
      decision: "Accept"
    )

    min_duration = (event.end - event.start) / 60
    i = 0
    (min_duration / 15).times do
      Block.create(
        user_id: current_user.id,
        start: event.start + i
      )
      i += (15 * 60)
    end

    if params[:groups]
      params[:groups].each do |group|
        event_invite.update(group_id: Group.find_by(name: group).id)
        
        members = []
        GroupInvitation.where(group_id: Group.find_by(name: group).id, decision: "Accept").each do |group_invite|
          members << User.find(group_invite.user_id)
        end
        members -= [current_user]
        members.each do |member|
          EventInvitation.create(
            event_id: event.id,
            group_id: Group.find_by(name: group).id,
            user_id: member.id,
            mem_type: "Partcipant",
            decision: "pending"
          )
        end
      end
    end
    redirect_to '/events'
  end

  def show
    @event = Event.find(params[:id])
    render 'show.html.erb'
  end

  def edit
    @event = Event.find(params[:id])
    render 'edit.html.erb'
  end

  def update
    @event = Event.find(params[:id])
    @event.update(
      name: params[:name],
      start_date: params[:start_date],
      end_date: params[:end_date],
      start_time: params[:start_time],
      end_time: params[:end_time],
      # duration: params[:duration],
      location: params[:location],
      # status: "sent"
    )
    redirect_to "/events/#{@event.id}"
  end

  def destroy
    @event = Event.find(params[:id])
    @event.update(status: "cancelled")
    redirect_to '/events'
  end
end