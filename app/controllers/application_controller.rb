class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:user_id]
      current_user ||= User.find_by(id: session[:user_id])
    end
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to '/login' unless current_user
  end

  def pending_events_count
    events = []
    EventInvitation.where(user_id: current_user.id, decision: "pending").each do |invite|
      if Event.find(invite.event_id).status == "sent"
        events << invite
      end
    end
    events.count
  end
  helper_method :pending_events_count

  def pending_options_array
    event_ids = Option.where(user_id: current_user.id, vote: "pending").distinct.pluck(:event_id)
    event_ids.each do |event_id|
      if Event.find(event_id).status == "sent" || Event.find(event_id).status == "cancelled"
        event_ids.delete(event_id)
      end
    end
    event_ids
  end
  helper_method :pending_options_array

  def option_responses_count
    owned_events = []
    EventInvitation.where(user_id: current_user, mem_type: "owner").each do |invite|
      if Event.find(invite.event_id).status == "sent options" && Option.find_by(event_id: invite.event_id, vote: "yes")
        owned_events << invite
      end
    end
    owned_events.count
  end
  helper_method :option_responses_count
end