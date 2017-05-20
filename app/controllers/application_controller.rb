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
    # @events = []
    # EventInvitation.where(user_id: current_user.id, decision: "pending").each do |invite|
    #   if Event.find(invite.event_id).status == "sent"
    #     @events << invite
    #   end
    # end
    # @events.count
    return 2
  end
end