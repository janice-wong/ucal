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
    if params[:submit] == "create"
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
      (min_duration / 15).to_i.times do
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

    elsif params[:submit] == "options" && params[:groups]
      @group_names = params[:groups]
      render 'options.html.erb'

    elsif params[:submit] == "group_cal" && params[:groups]
      if params[:groups].count == 1
        redirect_to "/groups/#{Group.find_by(name: params[:groups][0]).id}/events"
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    render 'show.html.erb'
  end

# need to build this out
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

# is this even used?
  def destroy
    @event = Event.find(params[:id])
    @event.update(status: "cancelled")
    redirect_to '/events'
  end

  def create_options
    day_to_num = {"Sunday" => 0, "Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6}

    start_date = Date.new(
      params["start_date"]["date(1i)"].to_i,
      params["start_date"]["date(2i)"].to_i,
      params["start_date"]["date(3i)"].to_i
    )

    end_date = Date.new(
      params["end_date"]["date(1i)"].to_i,
      params["end_date"]["date(2i)"].to_i,
      params["end_date"]["date(3i)"].to_i
    )

    my_days = []
    params[:days].each do |day|
      my_days << day_to_num[day]
    end
    day_options = (start_date..end_date).to_a.select { |k| my_days.include?(k.wday) }
    
    start_time = Time.new(
      params["start_date"]["date(1i)"].to_i,
      params["start_date"]["date(2i)"].to_i,
      params["start_date"]["date(3i)"].to_i,
      params["start_time"]["time(4i)"].to_i,
      params["start_time"]["time(5i)"].to_i
    )

    end_time = Time.new(
      params["start_date"]["date(1i)"].to_i,
      params["start_date"]["date(2i)"].to_i,
      params["start_date"]["date(3i)"].to_i,
      params["end_time"]["time(4i)"].to_i,
      params["end_time"]["time(5i)"].to_i
    )
    range = (end_time - start_time) / 60

    if params[:duration_unit] == "min"
      min = params[:duration].to_i
    else
      min = (params[:duration].to_i * 60).to_i
    end
    
    count = ((range - min) / 15) + 1
    
    # day_time_options is an array of all available options
    day_time_options = []
    day_options.each do |day_option|
      start_time = DateTime.new(
        day_option.year,
        day_option.month,
        day_option.mday,
        start_time.hour,
        start_time.min
      )
      
      (count.to_i).times do
        option = []
        i = 0
        (min / 15).times do
          option << (start_time + i.minutes).strftime("%a, %b %d %I:%M %P")
          i += 15
        end

        day_time_options.push(
          {
            start: option,
            available: true
          }
        )

        start_time += 15.minutes
      end
    end
    
    # now we need to look through the blocks by member and remove from day_time_options if found

    members = []
    # params[:groups].each do |group|
      # group.group_invitations.where(decision: "Accept").each do |invitation|
      Group.find_by(name: params[:group_names][0]).group_invitations.where(decision: "Accept").each do |invitation|
      # Group.find(params[:groups][0].id).group_invitations.where(decision: "Accept").each do |invitation|
        members << User.find(invitation.user_id)
      end
    # end
    members.uniq!

    member_blocks = []
    members.each do |member|
      Block.where(user_id: member.id).each do |block|
        member_blocks << (block.start).strftime("%a, %b %d %I:%M %P")
      end
    end
    
    day_time_options.each do |day_time_option|
      if (day_time_option[:start] & member_blocks) != []
        day_time_option.update(available: false)
      end
    end

    @available_options = day_time_options.select { |option| option[:available] == true }
    @groups = params[:group_names]

    render 'presented_options.html.erb'
  end

  def send_options
    
  end
end