class TwilioController < ApplicationController
skip_before_action :verify_authenticity_token

  def process_response
    user = User.find_by(phone: params[:From])
    if params[:Body][2] == "G"
      group_id = params[:Body][4..params[:Body].length].to_i
      decision = ""
      if params[:Body][0] == "Y"
        decision = "Yes"
      elsif params[:Body][0] == "N"
        decision = "No"
      end

      GroupInvitation.find_by(group_id: group_id, user_id: user.id).update(decision: decision)
    elsif params[:Body][2] == "E"
      event_id = params[:Body][4..params[:Body].length].to_i
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