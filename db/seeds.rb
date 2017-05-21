Option.all.destroy_all
Block.all.destroy_all
GroupInvitation.all.destroy_all
EventInvitation.all.destroy_all
Event.all.destroy_all
Group.all.destroy_all
Friendship.all.destroy_all
User.all.destroy_all

User.create!([
  {name: "Hanna", email: "hanna@hanna", phone: "", password_digest: "$2a$10$h4vnO.n4.wjuav1JW/bC5e/ZcRw4EV1hcl6bJ/ONVnbeYNtui5ttW", status: "active", preference: nil},
  {name: "Judy", email: "judy@judy", phone: "", password_digest: "$2a$10$vkGJEbIn3IJ2t07Jn/5n4eTNiDfv3cseoC9IjdZWxE0.r3L5xuUuu", status: "active", preference: nil},
  {name: "Osama", email: "osama@osama", phone: "", password_digest: "$2a$10$9WSGi2ztFB6ekUaHVoNMv.7ToqhVN4RUVENXXYslATVts2bm9mnkG", status: "active", preference: nil},
  {name: "Derek", email: "derek@derek", phone: "", password_digest: "$2a$10$yY0avciv7.EUIQTTan33y.SXwPbKmVuP/w8efIRllHWvbgpUAjNUG", status: "active", preference: nil},
  {name: "Amanda", email: "amanda@amanda", phone: "", password_digest: "$2a$10$34az8GVPKLIRzWaL1k6r5.ZWGtcD698KVwDRIolVmTYt9XmPejbNW", status: "active", preference: nil},
  {name: "Samer", email: "samer@samer", phone: "", password_digest: "$2a$10$jDCqo80bsquIdIgNc3zkDuOfQh5rTuQ7vx/3/r/6MdqeWFpSx0WL6", status: "active", preference: nil},
  {name: "Carlo", email: "carlo@carlo", phone: "", password_digest: "$2a$10$dG5HfeIt3XMhi0RBAQkJt.4/Do/dfH8.Rno/S9We7vX./b8EeZP4a", status: "active", preference: nil},
  {name: "Kelly", email: "kelly@kelly", phone: "3154812601", password_digest: "$2a$10$Zio7j9up76mq4Ji4bYi.4OeAhlGkFglEi5pSm8s/kRV5PnbQqJehS", status: "active", preference: "phone"},
  {name: "Janice", email: "janice@janice", phone: "9176087576", password_digest: "$2a$10$b4GOBZEyMUyvFckY3WrirO0h/su.nzt0VMCcw4Mzu7BgiVh/RSxty", status: "active", preference: "phone"},
  {name: "Tom", email: "tom@tom", phone: "", password_digest: "$2a$10$WvjVUB5zA4SFA8flg33Ib.hGOH/e5lrPRms1NoNmyN7pIlEjZJlvO", status: "active", preference: nil},
  {name: "Neil", email: "neil@neil", phone: nil, password_digest: "$2a$10$Oe0vw9lzplulqsXfijR9zeLUNWYKvttLRQF1Ob4tEAcxTdxV1G5Oi", status: "active", preference: "email"}
])

Friendship.create!([
  {user_id: 9, friend_id: 5},
  {user_id: 9, friend_id: 2},
  {user_id: 9, friend_id: 1},
  {user_id: 9, friend_id: 4},
  {user_id: 9, friend_id: 8},
  {user_id: 3, friend_id: 6},
  {user_id: 9, friend_id: 7},
  {user_id: 9, friend_id: 3},
  {user_id: 9, friend_id: 11},
  {user_id: 3, friend_id: 1},
  {user_id: 3, friend_id: 7},
  {user_id: 8, friend_id: 11},
  {user_id: 8, friend_id: 4},
  {user_id: 10, friend_id: 9},
  {user_id: 2, friend_id: 8},
  {user_id: 11, friend_id: 4}
])
Group.create!([
  {name: "Sista Sista", status: "active", share_cal: true},
  {name: "Technique", status: "active", share_cal: false},
  {name: "ayy ladies", status: "active", share_cal: true},
  {name: "testing", status: "cancelled", share_cal: true},
  {name: "v1", status: "active", share_cal: false}
])
Event.create!([
  {name: "Not sure yet but something", location: "TBD", status: "sent", start: "2017-05-26 20:00:00", end: "2017-05-26 21:00:00"},
  {name: "Dancehall", location: "Peridance", status: "sent options", start: nil, end: nil},
  {name: "Me, Myself, and I", location: "12 Corners", status: "sent", start: "2017-05-20 12:00:00", end: "2017-05-20 18:00:00"},
  {name: "Walk Nala", location: "", status: "sent", start: "2017-05-31 14:00:00", end: "2017-05-31 15:00:00"},
  {name: "Seeeester Time", location: "Dingleberries", status: "sent", start: "2017-06-09 12:00:00", end: "2017-06-09 13:00:00"},
  {name: "More Seester Time", location: "", status: "sent options", start: nil, end: nil},
  {name: "Lie in Grass", location: "", status: "sent", start: "2017-05-27 15:00:00", end: "2017-05-27 16:00:00"}
])
EventInvitation.create!([
  {event_id: 3, group_id: nil, user_id: 9, mem_type: "owner", decision: "Accept"},
  {event_id: 4, group_id: nil, user_id: 5, mem_type: "owner", decision: "Accept"},
  {event_id: 5, group_id: 1, user_id: 9, mem_type: "owner", decision: "Accept"},
  {event_id: 5, group_id: 1, user_id: 5, mem_type: "Partcipant", decision: "pending"},
  {event_id: 6, group_id: 1, user_id: 9, mem_type: "owner", decision: "Accept"},
  {event_id: 7, group_id: 2, user_id: 7, mem_type: "owner", decision: "Accept"},
  {event_id: 7, group_id: 2, user_id: 1, mem_type: "Participant", decision: "Accept"},
  {event_id: 7, group_id: 2, user_id: 3, mem_type: "Participant", decision: "Decline"},
  {event_id: 1, group_id: 3, user_id: 8, mem_type: "owner", decision: "Accept"},
  {event_id: 1, group_id: 3, user_id: 9, mem_type: "Partcipant", decision: "pending"},
  {event_id: 1, group_id: 3, user_id: 2, mem_type: "Partcipant", decision: "pending"},
  {event_id: 7, group_id: 2, user_id: 9, mem_type: "Participant", decision: "Accept"},
  {event_id: 2, group_id: 5, user_id: 8, mem_type: "owner", decision: "Accept"}
])
GroupInvitation.create!([
  {user_id: 9, group_id: 1, mem_type: "owner", decision: "Accept"},
  {user_id: 5, group_id: 1, mem_type: "member", decision: "Accept"},
  {user_id: 9, group_id: 2, mem_type: "owner", decision: "Accept"},
  {user_id: 3, group_id: 2, mem_type: "member", decision: "Accept"},
  {user_id: 1, group_id: 2, mem_type: "member", decision: "Accept"},
  {user_id: 7, group_id: 2, mem_type: "member", decision: "Accept"},
  {user_id: 8, group_id: 3, mem_type: "owner", decision: "Accept"},
  {user_id: 9, group_id: 3, mem_type: "member", decision: "Accept"},
  {user_id: 9, group_id: 4, mem_type: "owner", decision: "Accept"},
  {user_id: 2, group_id: 4, mem_type: "member", decision: "Decline"},
  {user_id: 2, group_id: 3, mem_type: "member", decision: "Accept"},
  {user_id: 11, group_id: 5, mem_type: "owner", decision: "Accept"},
  {user_id: 4, group_id: 5, mem_type: "member", decision: "Accept"},
  {user_id: 8, group_id: 5, mem_type: "member", decision: "Accept"},
  {user_id: 9, group_id: 5, mem_type: "member", decision: "Accept"}
])
Block.create!([
  {user_id: 9, start: "2017-05-20 12:00:00"},
  {user_id: 9, start: "2017-05-20 12:15:00"},
  {user_id: 9, start: "2017-05-20 12:30:00"},
  {user_id: 9, start: "2017-05-20 12:45:00"},
  {user_id: 9, start: "2017-05-20 13:00:00"},
  {user_id: 9, start: "2017-05-20 13:15:00"},
  {user_id: 9, start: "2017-05-20 13:30:00"},
  {user_id: 9, start: "2017-05-20 13:45:00"},
  {user_id: 9, start: "2017-05-20 14:00:00"},
  {user_id: 9, start: "2017-05-20 14:15:00"},
  {user_id: 9, start: "2017-05-20 14:30:00"},
  {user_id: 9, start: "2017-05-20 14:45:00"},
  {user_id: 9, start: "2017-05-20 15:00:00"},
  {user_id: 9, start: "2017-05-20 15:15:00"},
  {user_id: 9, start: "2017-05-20 15:30:00"},
  {user_id: 9, start: "2017-05-20 15:45:00"},
  {user_id: 9, start: "2017-05-20 16:00:00"},
  {user_id: 9, start: "2017-05-20 16:15:00"},
  {user_id: 9, start: "2017-05-20 16:30:00"},
  {user_id: 9, start: "2017-05-20 16:45:00"},
  {user_id: 9, start: "2017-05-20 17:00:00"},
  {user_id: 9, start: "2017-05-20 17:15:00"},
  {user_id: 9, start: "2017-05-20 17:30:00"},
  {user_id: 9, start: "2017-05-20 17:45:00"},
  {user_id: 5, start: "2017-05-31 14:00:00"},
  {user_id: 5, start: "2017-05-31 14:15:00"},
  {user_id: 5, start: "2017-05-31 14:30:00"},
  {user_id: 5, start: "2017-05-31 14:45:00"},
  {user_id: 9, start: "2017-06-09 12:00:00"},
  {user_id: 9, start: "2017-06-09 12:15:00"},
  {user_id: 9, start: "2017-06-09 12:30:00"},
  {user_id: 9, start: "2017-06-09 12:45:00"},
  {user_id: 7, start: "2017-05-20 15:15:00"},
  {user_id: 7, start: "2017-05-20 15:30:00"},
  {user_id: 7, start: "2017-05-20 15:45:00"},
  {user_id: 7, start: "2017-05-20 16:00:00"},
  {user_id: 1, start: "2017-05-27 15:00:00"},
  {user_id: 1, start: "2017-05-27 15:15:00"},
  {user_id: 1, start: "2017-05-27 15:30:00"},
  {user_id: 1, start: "2017-05-27 15:45:00"},
  {user_id: 8, start: "2017-05-26 20:00:00"},
  {user_id: 8, start: "2017-05-26 20:15:00"},
  {user_id: 8, start: "2017-05-26 20:30:00"},
  {user_id: 8, start: "2017-05-26 20:45:00"},
  {user_id: 9, start: "2017-05-27 15:00:00"},
  {user_id: 9, start: "2017-05-27 15:15:00"},
  {user_id: 9, start: "2017-05-27 15:30:00"},
  {user_id: 9, start: "2017-05-27 15:45:00"}
])
Option.create!([
  {start: "2017-05-21 10:00:00", end: "2017-05-21 12:00:00", event_id: 6, user_id: 5, vote: "yes"},
  {start: "2017-05-27 13:00:00", end: "2017-05-27 15:00:00", event_id: 2, user_id: 4, vote: "pending"},
  {start: "2017-05-27 13:00:00", end: "2017-05-27 15:00:00", event_id: 2, user_id: 9, vote: "pending"},
  {start: "2017-06-03 13:00:00", end: "2017-06-03 15:00:00", event_id: 2, user_id: 4, vote: "pending"},
  {start: "2017-06-03 13:00:00", end: "2017-06-03 15:00:00", event_id: 2, user_id: 9, vote: "pending"},
  {start: "2017-06-03 14:00:00", end: "2017-06-03 16:00:00", event_id: 2, user_id: 4, vote: "pending"},
  {start: "2017-06-03 14:00:00", end: "2017-06-03 16:00:00", event_id: 2, user_id: 9, vote: "pending"},
  {start: "2017-05-27 13:00:00", end: "2017-05-27 15:00:00", event_id: 2, user_id: 11, vote: "yes"},
  {start: "2017-06-03 13:00:00", end: "2017-06-03 15:00:00", event_id: 2, user_id: 11, vote: "yes"},
  {start: "2017-06-03 14:00:00", end: "2017-06-03 16:00:00", event_id: 2, user_id: 11, vote: "yes"},
  {start: "2017-05-27 14:00:00", end: "2017-05-27 15:00:00", event_id: 7, user_id: 9, vote: "yes"},
  {start: "2017-05-27 14:30:00", end: "2017-05-27 15:30:00", event_id: 7, user_id: 9, vote: "yes"},
  {start: "2017-05-27 15:00:00", end: "2017-05-27 16:00:00", event_id: 7, user_id: 9, vote: "no"},
  {start: "2017-05-27 14:30:00", end: "2017-05-27 15:30:00", event_id: 7, user_id: 3, vote: "yes"},
  {start: "2017-05-27 15:00:00", end: "2017-05-27 16:00:00", event_id: 7, user_id: 3, vote: "yes"},
  {start: "2017-05-27 14:00:00", end: "2017-05-27 15:00:00", event_id: 7, user_id: 3, vote: "no"},
  {start: "2017-05-27 14:00:00", end: "2017-05-27 15:00:00", event_id: 7, user_id: 1, vote: "yes"},
  {start: "2017-05-27 14:30:00", end: "2017-05-27 15:30:00", event_id: 7, user_id: 1, vote: "yes"},
  {start: "2017-05-27 15:00:00", end: "2017-05-27 16:00:00", event_id: 7, user_id: 1, vote: "yes"}
])