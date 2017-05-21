class TwilioController < ApplicationController
skip_before_action :verify_authenticity_token

  def process_response
    user = User.find_by(phone: params[:From][2..params[:From].length - 1])
    decision = ""

    sent_events = []
    EventInvitation.where(user_id: user.id, decision: "pending").each do |invite|
      if Event.find(invite.event_id).status == "sent"
        sent_events << invite.event_id
      end
    end

    if (params[:Body][0..1] == "NO" && sent_events.index(params[:Body][3..-2].to_i) && (params[:Body][-1] == "E" || params[:Body][-1] == "G")) || (params[:Body][0..2] == "NO" && sent_events.index(params[:Body][4..-2].to_i) && (params[:Body][-1] == "E" || params[:Body][-1] == "G"))

      if params[:Body][-1] == "G"
        if params[:Body][0] == "Y"
          decision = "Yes"
          group_id = params[:Body][4..-2].to_i
        elsif params[:Body][0] == "N"
          decision = "No"
          group_id = params[:Body][3..-2].to_i
        end
        GroupInvitation.find_by(group_id: group_id, user_id: user.id).update(decision: decision)
      elsif params[:Body][-1] == "E"
        if params[:Body][0] == "Y"
          decision = "Yes"
          event_id = params[:Body][4..-2].to_i
        elsif params[:Body][0] == "N"
          decision = "No"
          event_id = params[:Body][3..-2].to_i
        end
        EventInvitation.find_by(event_id: event_id, user_id: user.id).update(decision: decision)
      end

    else
      twilio_client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_token"]
      twilio_client.account.messages.create(
        :from => "+1#{ENV["twilio_phone_number"]}",
        :to => "+1#{user.phone}",
        :body => "Ok but actually do it right this time"
      )
    end
  end
end