class Event < ApplicationRecord
  has_many :event_invitations
  has_many :options

  def friendly_time(time)
    return time.strftime("%a, %b %e - %l:%M %p")
  end
end
