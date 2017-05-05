class Group < ApplicationRecord
  has_many :group_invitations
  validates_presence_of :share_cal
end