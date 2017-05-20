class OptionsController < ApplicationController
  def create
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
      Group.find(15).group_invitations.where(decision: "Accept").each do |invitation|
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

    # redirect_to '/events/new'
    render 'presented_options.html.erb'
  end
end
