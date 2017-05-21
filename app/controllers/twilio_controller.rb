class TwilioController < ApplicationController
skip_before_action :verify_authenticity_token

  def process_response
    p '-' * 100
    p params
    p params[:From]
    p params[:Body]

    user = User.find_by(phone: params[:From])
    if params[:Body][params[:Body].length - 1] == "G"
      group_id = params[:Body][2..params[:Body].length - 2].to_i
      decision = ""
      if params[:Body][0] == "Y"
        decision = "Yes"
      elsif params[:Body][0] == "N"
        decision = "No"
      end

      GroupInvitation.find_by(group_id: group_id, user_id: user.id).update(decision: decision)
    elsif params[:Body][params[:Body].length - 1] == "E"
      event_id = params[:Body][2..params[:Body].length - 2].to_i
      decision = ""
      if params[:Body][0] == "Y"
        decision = "Yes"
      elsif params[:Body][0] == "N"
        decision = "No"
      end

      EventInvitation.find_by(event_id: event_id, user_id: user.id).update(decision: decision)
    end
  end
end