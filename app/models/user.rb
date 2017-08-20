class User < ApplicationRecord
  has_secure_password
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendhips, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendhips, source: :user
  has_many :group_invitations
  has_many :blocks
  has_many :options
  has_many :event_invitations
end
