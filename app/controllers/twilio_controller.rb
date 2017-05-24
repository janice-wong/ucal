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

    sent_groups = []
    GroupInvitation.where(user_id: user.id, decision: "pending").each do |invite|
      if Group.find(invite.group_id).status == "active"
        sent_groups << invite.group_id
      end
    end

    twilio_client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_token"]

    if (params[:Body][0..1] == "NO" && sent_events.index(params[:Body][3..-2].to_i) && params[:Body][-1] == "E") || (params[:Body][0..2] == "YES" && sent_events.index(params[:Body][4..-2].to_i) && params[:Body][-1] == "E")

      if params[:Body][0] == "Y"
        decision = "Accept"
        event_id = params[:Body][4..-2].to_i
      elsif params[:Body][0] == "N"
        decision = "Decline"
        event_id = params[:Body][3..-2].to_i
      end
      EventInvitation.find_by(event_id: event_id, user_id: user.id).update(decision: decision)

      twilio_client.account.messages.create(
        :from => "+1#{ENV["twilio_phone_number"]}",
        :to => "+1#{user.phone}",
        :body => "Response received"
      )

    elsif (params[:Body][0..1] == "NO" && sent_groups.index(params[:Body][3..-2].to_i) && params[:Body][-1] == "G") || (params[:Body][0..2] == "YES" && sent_groups.index(params[:Body][4..-2].to_i) && params[:Body][-1] == "G")

      if params[:Body][0] == "Y"
        decision = "Accept"
        group_id = params[:Body][4..-2].to_i
      elsif params[:Body][0] == "N"
        decision = "Decline"
        group_id = params[:Body][3..-2].to_i
      end
      GroupInvitation.find_by(group_id: group_id, user_id: user.id).update(decision: decision)

      twilio_client.account.messages.create(
        :from => "+1#{ENV["twilio_phone_number"]}",
        :to => "+1#{user.phone}",
        :body => "Response received"
      )

    else

      twilio_client.account.messages.create(
        :from => "+1#{ENV["twilio_phone_number"]}",
        :to => "+1#{user.phone}",
        :body => "Ok but actually do it right this time"
      )

    end
  end
end