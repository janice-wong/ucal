class EventsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if params[:login] == "success"
      @login_success = "Successfully logged in!"
    end
    @pending_events = []
    @accepted_events = []
    if current_user
      EventInvitation.where(user_id: current_user.id).each do |invitation|
        if invitation.decision == "pending" && Event.find(invitation.event_id).status != "cancelled"
          @pending_events << invitation.event
        elsif invitation.decision == "Accept" && Event.find(invitation.event_id).status != "cancelled"
          @accepted_events << invitation.event
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

    if params[:start]
      @default_start_year = params[:start][11..14].to_i.to_i
      @default_start_month = DateTime.strptime(params[:start][4..6], "%B").month
      @default_start_date = params[:start][8..9].to_i
      @default_start_hour = params[:start][16..17].to_i
      @default_start_min = params[:start][19..20].to_i

      @default_end_year = params[:end][11..14].to_i
      @default_end_month = DateTime.strptime(params[:end][4..6], "%B").month
      @default_end_date = params[:end][8..9].to_i
      @default_end_hour = params[:end][16..17].to_i
      @default_end_min = params[:end][19..20].to_i
    end

    if params[:group]
      @chosen_group_id = params[:group].to_i
    end
  end

  def create
    if params[:submit] == "create"
      event = Event.create(
        name: params[:name],
        start: DateTime.strptime(params[:start], "%m/%d/%Y %l:%M %p"),
        end: DateTime.strptime(params[:end], "%m/%d/%Y %l:%M %p"),
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

      @twilio_client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_token"]

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

            if member.preference == "phone"
              @twilio_client.account.sms.messages.create(
                :from => "+1#{ENV["twilio_phone_number"]}",
                :to => "+1#{member.phone}",
                :body => "#{EventInvitation.find_by(event_id: event.id, mem_type: 'owner').user.name} invites you to #{event.name} on #{event.start.strftime('%a, %b %d %I:%M %P')}. Reply with Y E-#{event.id} or N E-#{event.id} to accept or decline."
              )
            end
          end
        end
      end
      redirect_to '/events'

    elsif params[:submit] == "options" && params[:groups]
      @group_names = params[:groups]
      event = Event.create(
        name: params[:name],
        location: params[:location]
      )

      invite = EventInvitation.create(
        user_id: current_user.id,
        mem_type: "owner",
        event_id: event.id,
        decision: "Accept"
      )
      if @group_names.count == 1
        invite.update(group_id: Group.find_by(name: @group_names[0]).id)
      end

      @event = event
      render 'options.html.erb'

    elsif params[:submit] == "group_cal" && params[:groups]
      if params[:groups].count == 1
        redirect_to "/groups/#{Group.find_by(name: params[:groups][0]).id}/events?name=#{params[:name]}"
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    @event_pending = EventInvitation.where(event_id: @event.id, decision: "pending")
    @event_accept = EventInvitation.where(event_id: @event.id, decision: "Accept")
    @event_decline = EventInvitation.where(event_id: @event.id, decision: "Decline")
    render 'show.html.erb'
  end

# need to build edit method out
  def edit
    @event = Event.find(params[:id])
    redirect_to "/events/#{@event.id}"
  end

# need to build update method out
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

# is destroy method even used?
  def destroy
    @event = Event.find(params[:id])
    @event.update(status: "cancelled")
    redirect_to '/events'
  end

  def create_options
    day_to_num = {"Sunday" => 0, "Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6}

    start_date = Date.new(
      params["start_date"][6..9].to_i,
      params["start_date"][0..1].to_i,
      params["start_date"][3..4].to_i
    )

    end_date = Date.new(
      params["end_date"][6..9].to_i,
      params["end_date"][0..1].to_i,
      params["end_date"][3..4].to_i
    )

    my_days = []
    params[:days].each do |day|
      my_days << day_to_num[day]
    end
    day_options = (start_date..end_date).to_a.select { |k| my_days.include?(k.wday) }
    
    start_hr = Time.strptime(params["start_time"], "%l:%M %p").strftime("%H:%M")[0..1]
    start_min = Time.strptime(params["start_time"], "%l:%M %p").strftime("%H:%M")[3..4]

    end_hr = Time.strptime(params["end_time"], "%l:%M %p").strftime("%H:%M")[0..1]
    end_min = Time.strptime(params["end_time"], "%l:%M %p").strftime("%H:%M")[3..4]

    start_time = Time.new(
      params["start_date"][6..9].to_i,
      params["start_date"][0..1].to_i,
      params["start_date"][3..4].to_i,
      start_hr,
      start_min
    )

    end_time = Time.new(
      params["start_date"][6..9].to_i,
      params["start_date"][0..1].to_i,
      params["start_date"][3..4].to_i,
      end_hr,
      end_min
    )

    range = (end_time - start_time) / 60

    if params[:duration_unit] == "min"
      @min = params[:duration].to_i
    else
      @min = (params[:duration].to_i * 60).to_i
    end
    
    count = ((range - @min) / 15) + 1
    
    # day_time_options is an array of all available options
    day_time_options = []
    day_options.each do |day_option|
      start = DateTime.new(
        day_option.year,
        day_option.month,
        day_option.day,
        start_time.hour,
        start_time.min
      )
      
      (count.to_i).times do
        option = []
        i = 0
        (@min / 15).times do
          option << (start + i.minutes).strftime("%a, %b %d %I:%M %P")
          i += 15
        end

        day_time_options.push(
          {
            start: option,
            available: true
          }
        )

        start += 15.minutes
      end
    end

    # now we need to look through the blocks by member and remove from day_time_options if found
    members = []
      Group.find_by(name: params[:group_names][0]).group_invitations.where(decision: "Accept").each do |invitation|
        members << User.find(invitation.user_id)
      end

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
    @group_names = params[:group_names]
    @event = Event.find_by(name: params[:event_name])

    @options = []
    @available_options.each do |available_option|
      @options << [available_option[:start].first, (Time.strptime(available_option[:start].last, "%a, %b %d %I:%M %P") + 15.minutes).strftime("%a, %b %d %I:%M %P")]
    end

    render 'presented_options.html.erb'
  end

  def send_options
    event = Event.find_by(name: params[:event_name])
    event.update(
      status: "sent options"
    )

    user_array = []
    GroupInvitation.where(group_id: Group.find_by(name: params[:group_name]).id).each do |invitation|
      user_array << invitation.user
    end

    option_array = []
    min = params[:min].to_i

    params[:options].each do |option|
      start = Time.strptime(option, "%a, %b %d %I:%M %p") - 4.hours
      option_array << {
        :start_time => start,
        :end_time => start + min.minutes
      }
    end

    option_array.each do |option|
      (user_array - [current_user]).each do |user|
        Option.create(
          start: option[:start_time],
          end: option[:end_time],
          event_id: event.id,
          user_id: user.id,
          vote: "pending"
        )
      end
    end

    redirect_to '/events'
  end

  def option_proposals
  end

  def vote_on_options
    params[:option_ids].each do |option_id|
      Option.find(option_id).update(vote: "yes")
    end

    Option.where(user_id: current_user.id, event_id: params[:event_id], vote: "pending").each do |pending_option|
      pending_option.update(vote: "no")
    end

    redirect_to '/option_proposals'
  end

  def option_responses
    events = []
    EventInvitation.where(user_id: current_user.id, mem_type: "owner").each do |invite|
      if Option.find_by(event_id: invite.event_id) && Event.find(invite.event_id).status == "sent options"
        events << invite.event
      end
    end

    @event_options = {}

    events.each do |event|
      options = {}
      @event_options[event] = options
      Option.where(event_id: event.id).select(:start).uniq.each do |option|
        votes = []
        full_option = Option.find_by(event_id: event.id, start: option.start)
        options[full_option] = votes
        Option.where(event_id: event.id, start: option.start).each do |option_vote|
          if option_vote.vote == "yes"
            votes << option_vote.user
          end
        end
      end
    end
  end

  def send_final
    event = Event.find(Option.find(params[:option]).event_id)

    event.update(
      start: Option.find(params[:option]).start,
      end: Option.find(params[:option]).end,
      status: "sent"
    )

    participants = []
    GroupInvitation.where(group_id: EventInvitation.find_by(event_id: event.id).group_id, decision: "Accept").each do |invite|
      participants << invite.user
    end

    (participants - [current_user]).each do |member|
      EventInvitation.create(
        event_id: event.id,
        group_id: EventInvitation.find_by(event_id: event.id).group_id,
        user_id: member.id,
        mem_type: "Participant",
        decision: "pending"
      )
    end

    redirect_to "/events"
  end
end