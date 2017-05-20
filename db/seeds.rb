Option.all.destroy_all
Event.all.destroy_all
EventInvitation.all.destroy_all
Group.all.destroy_all
GroupInvitation.all.destroy_all
Block.all.destroy_all
User.all.destroy_all
Friendship.all.destroy_all

Block.create!([
  {user_id: 5, start: "2017-05-20 12:00:00"},
  {user_id: 5, start: "2017-05-20 12:15:00"},
  {user_id: 5, start: "2017-05-20 12:30:00"},
  {user_id: 5, start: "2017-05-20 12:45:00"},
  {user_id: 5, start: "2017-05-20 13:00:00"},
  {user_id: 5, start: "2017-05-20 13:15:00"},
  {user_id: 5, start: "2017-05-20 13:30:00"},
  {user_id: 5, start: "2017-05-20 13:45:00"},
  {user_id: 5, start: "2017-05-20 14:00:00"},
  {user_id: 5, start: "2017-05-20 14:15:00"},
  {user_id: 5, start: "2017-05-20 14:30:00"},
  {user_id: 5, start: "2017-05-20 14:45:00"},
  {user_id: 5, start: "2017-05-20 15:00:00"},
  {user_id: 5, start: "2017-05-20 15:15:00"},
  {user_id: 5, start: "2017-05-20 15:30:00"},
  {user_id: 5, start: "2017-05-20 15:45:00"},
  {user_id: 5, start: "2017-05-20 16:00:00"},
  {user_id: 5, start: "2017-05-20 16:15:00"},
  {user_id: 5, start: "2017-05-20 16:30:00"},
  {user_id: 5, start: "2017-05-20 16:45:00"},
  {user_id: 5, start: "2017-05-20 17:00:00"},
  {user_id: 5, start: "2017-05-20 17:15:00"},
  {user_id: 5, start: "2017-05-20 17:30:00"},
  {user_id: 5, start: "2017-05-20 17:45:00"},
  {user_id: 6, start: "2017-05-31 14:00:00"},
  {user_id: 6, start: "2017-05-31 14:15:00"},
  {user_id: 6, start: "2017-05-31 14:30:00"},
  {user_id: 6, start: "2017-05-31 14:45:00"},
  {user_id: 5, start: "2017-06-09 12:00:00"},
  {user_id: 5, start: "2017-06-09 12:15:00"},
  {user_id: 5, start: "2017-06-09 12:30:00"},
  {user_id: 5, start: "2017-06-09 12:45:00"},
  {user_id: 11, start: "2017-05-20 15:15:00"},
  {user_id: 11, start: "2017-05-20 15:30:00"},
  {user_id: 11, start: "2017-05-20 15:45:00"},
  {user_id: 11, start: "2017-05-20 16:00:00"},
  {user_id: 10, start: "2017-05-27 15:00:00"},
  {user_id: 10, start: "2017-05-27 15:15:00"},
  {user_id: 10, start: "2017-05-27 15:30:00"},
  {user_id: 10, start: "2017-05-27 15:45:00"},
  {user_id: 8, start: "2017-05-26 20:00:00"},
  {user_id: 8, start: "2017-05-26 20:15:00"},
  {user_id: 8, start: "2017-05-26 20:30:00"},
  {user_id: 8, start: "2017-05-26 20:45:00"},
  {user_id: 5, start: "2017-05-27 15:00:00"},
  {user_id: 5, start: "2017-05-27 15:15:00"},
  {user_id: 5, start: "2017-05-27 15:30:00"},
  {user_id: 5, start: "2017-05-27 15:45:00"}
])
Event.create!([
  {name: "Not sure yet but something", location: "TBD", status: "sent", start: "2017-05-26 20:00:00", end: "2017-05-26 21:00:00"},
  {name: "Me, Myself, and I", location: "12 Corners", status: "sent", start: "2017-05-20 12:00:00", end: "2017-05-20 18:00:00"},
  {name: "Walk Nala", location: "", status: "sent", start: "2017-05-31 14:00:00", end: "2017-05-31 15:00:00"},
  {name: "Seeeester Time", location: "Dingleberries", status: "sent", start: "2017-06-09 12:00:00", end: "2017-06-09 13:00:00"},
  {name: "More Seester Time", location: "", status: "sent options", start: nil, end: nil},
  {name: "Lie in Grass", location: "", status: "sent", start: "2017-05-27 15:00:00", end: "2017-05-27 16:00:00"}
])
EventInvitation.create!([
  {event_id: 124, group_id: nil, user_id: 5, mem_type: "owner", decision: "Accept"},
  {event_id: 125, group_id: nil, user_id: 6, mem_type: "owner", decision: "Accept"},
  {event_id: 126, group_id: 36, user_id: 5, mem_type: "owner", decision: "Accept"},
  {event_id: 126, group_id: 36, user_id: 6, mem_type: "Partcipant", decision: "pending"},
  {event_id: 129, group_id: 36, user_id: 5, mem_type: "owner", decision: "Accept"},
  {event_id: 127, group_id: 37, user_id: 11, mem_type: "owner", decision: "Accept"},
  {event_id: 127, group_id: 37, user_id: 10, mem_type: "Participant", decision: "Accept"},
  {event_id: 127, group_id: 37, user_id: 9, mem_type: "Participant", decision: "Decline"},
  {event_id: 131, group_id: 38, user_id: 8, mem_type: "owner", decision: "Accept"},
  {event_id: 131, group_id: 38, user_id: 5, mem_type: "Partcipant", decision: "pending"},
  {event_id: 131, group_id: 38, user_id: 7, mem_type: "Partcipant", decision: "pending"},
  {event_id: 127, group_id: 37, user_id: 5, mem_type: "Participant", decision: "Accept"}
])
Friendship.create!([
  {user_id: 5, friend_id: 6},
  {user_id: 5, friend_id: 7},
  {user_id: 5, friend_id: 10},
  {user_id: 5, friend_id: 13},
  {user_id: 5, friend_id: 8},
  {user_id: 9, friend_id: 14},
  {user_id: 5, friend_id: 11},
  {user_id: 5, friend_id: 9},
  {user_id: 5, friend_id: 12},
  {user_id: 9, friend_id: 10},
  {user_id: 9, friend_id: 11},
  {user_id: 8, friend_id: 12},
  {user_id: 8, friend_id: 13},
  {user_id: 16, friend_id: 5},
  {user_id: 17, friend_id: 5},
  {user_id: 17, friend_id: 16},
  {user_id: 18, friend_id: 5},
  {user_id: 18, friend_id: 16},
  {user_id: 19, friend_id: 5},
  {user_id: 19, friend_id: 16},
  {user_id: 20, friend_id: 5},
  {user_id: 20, friend_id: 16},
  {user_id: 21, friend_id: 5},
  {user_id: 21, friend_id: 16},
  {user_id: 7, friend_id: 8}
])
Group.create!([
  {name: "Sista Sista", status: "active", share_cal: true},
  {name: "Technique", status: "active", share_cal: false},
  {name: "ayy ladies", status: "active", share_cal: true},
  {name: "testing", status: "cancelled", share_cal: true}
])
GroupInvitation.create!([
  {user_id: 5, group_id: 36, mem_type: "owner", decision: "Accept"},
  {user_id: 6, group_id: 36, mem_type: "member", decision: "Accept"},
  {user_id: 5, group_id: 37, mem_type: "owner", decision: "Accept"},
  {user_id: 9, group_id: 37, mem_type: "member", decision: "Accept"},
  {user_id: 10, group_id: 37, mem_type: "member", decision: "Accept"},
  {user_id: 11, group_id: 37, mem_type: "member", decision: "Accept"},
  {user_id: 8, group_id: 38, mem_type: "owner", decision: "Accept"},
  {user_id: 5, group_id: 38, mem_type: "member", decision: "Accept"},
  {user_id: 5, group_id: 42, mem_type: "owner", decision: "Accept"},
  {user_id: 7, group_id: 42, mem_type: "member", decision: "Decline"},
  {user_id: 7, group_id: 38, mem_type: "member", decision: "Accept"}
])
Option.create!([
  {start: "2017-05-21 10:00:00", end: "2017-05-21 12:00:00", event_id: 129, user_id: 6, vote: "yes"},
  {start: "2017-05-27 14:00:00", end: "2017-05-27 15:00:00", event_id: 127, user_id: 5, vote: "yes"},
  {start: "2017-05-27 14:30:00", end: "2017-05-27 15:30:00", event_id: 127, user_id: 5, vote: "yes"},
  {start: "2017-05-27 15:00:00", end: "2017-05-27 16:00:00", event_id: 127, user_id: 5, vote: "no"},
  {start: "2017-05-27 14:30:00", end: "2017-05-27 15:30:00", event_id: 127, user_id: 9, vote: "yes"},
  {start: "2017-05-27 15:00:00", end: "2017-05-27 16:00:00", event_id: 127, user_id: 9, vote: "yes"},
  {start: "2017-05-27 14:00:00", end: "2017-05-27 15:00:00", event_id: 127, user_id: 9, vote: "no"},
  {start: "2017-05-27 14:00:00", end: "2017-05-27 15:00:00", event_id: 127, user_id: 10, vote: "yes"},
  {start: "2017-05-27 14:30:00", end: "2017-05-27 15:30:00", event_id: 127, user_id: 10, vote: "yes"},
  {start: "2017-05-27 15:00:00", end: "2017-05-27 16:00:00", event_id: 127, user_id: 10, vote: "yes"}
])
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
  {name: "Neil", email: "neil@neil", phone: nil, password_digest: "$2a$10$Oe0vw9lzplulqsXfijR9zeLUNWYKvttLRQF1Ob4tEAcxTdxV1G5Oi", status: "active", preference: "email"},
  {name: "kaz", email: "kaz@kaz", phone: "", password_digest: "$2a$10$qPo5Noa41PDg3aTCDGuEt.1DVxSF4BSFBQsrj8FdnhX1wlUiDJKFS", status: "active", preference: nil},
  {name: "sonia", email: "sonia@sonia", phone: "9176087576", password_digest: "$2a$10$xvDVSMPsLrIJDu2t80EFTeWEYD4RmbNjD6qjVAOkYbBaUUR1KNeSa", status: "active", preference: "phone"},
  {name: "ALAN", email: "AWONG888@OPTONLINE.NET", phone: "9179217880", password_digest: "$2a$10$m3De5eM35o.HDW4nKjkSku0.4hl/NicN02WGBYwBYoilyFK7x.9gu", status: "active", preference: "phone"}
])
