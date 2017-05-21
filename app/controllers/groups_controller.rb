class GroupsController < ApplicationController
  def index
    @pending_groups = []
    @accepted_groups = []
    GroupInvitation.where(user_id: current_user[:id]).each do |invitation|
      if invitation.decision == "pending" && invitation.group.status == "active"
        @pending_groups << invitation.group
      elsif invitation.decision == "Accept" && invitation.group.status == "active"
        @accepted_groups << invitation.group
      end
    end
    render 'index.html.erb'
  end

  def new
    @friends = current_user.friends + current_user.inverse_friends
    render 'new.html.erb'
  end

  def create
    group = Group.create(
      name: params[:name],
      share_cal: params[:share_cal],
      status: "active"
    )

    GroupInvitation.create(
      user_id: current_user.id,
      group_id: group.id,
      mem_type: "owner",
      decision: "Accept"
    )
    
    @twilio_client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_token"]

    params[:friends].each do |friend|
      GroupInvitation.create(
        user_id: User.find_by(name: friend).id,
        group_id: group.id,
        mem_type: "member",
        decision: "pending"
      )

      if User.find_by(name: friend).preference == "phone"
        @twilio_client.account.messages.create(
          :from => "+1#{ENV["twilio_phone_number"]}",
          :to => "+1#{User.find_by(name: friend).phone}",
          :body => "Hi #{friend}! #{GroupInvitation.find_by(group_id: group.id, mem_type: 'owner').user.name} invites you to join #{group.name} on UCal! Reply with Y G-#{group.id} or N G-#{group.id} to accept or decline."
        )
      end
    end
    redirect_to '/groups'
  end

  def show
    @group = Group.find(params[:id])
    @group_pending = GroupInvitation.where(group_id: @group.id, decision: "pending")
    @group_accept = GroupInvitation.where(group_id: @group.id, decision: "Accept")
    @group_decline = GroupInvitation.where(group_id: @group.id, decision: "Decline")
    render 'show.html.erb'
  end

  def edit
    @group = Group.find(params[:id])
    render 'edit.html.erb'
  end

  def update
    @group = Group.find(params[:id])
    @group.update(
      name: params[:name],
      share_cal: params[:share_cal]
    )
    redirect_to "/groups/#{@group.id}"
  end

  def destroy
    @group = Group.find(params[:id])
    @group.update(status: "inactive")
    redirect_to '/groups'
  end

  def events
    @group = Group.find(params[:group_id])
    @event_name = params[:name]
    @events = []
    EventInvitation.where(group_id: @group.id).distinct.pluck(:event_id).each do |event_id|
      if Event.find(event_id).status == "sent"
        @events << Event.find(event_id)
      end
    end
  end
end