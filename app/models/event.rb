class Event < ApplicationRecord
  has_many :event_invitations

  def friendly_time(time)
    return time.strftime("%a, %b %e - %l:%M %p")
  end
end
