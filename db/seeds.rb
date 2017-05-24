Option.all.destroy_all
Block.all.destroy_all
GroupInvitation.all.destroy_all
EventInvitation.all.destroy_all
Event.all.destroy_all
Group.all.destroy_all
Friendship.all.destroy_all
User.all.destroy_all

Friendship.create!([
  {user_id: 9, friend_id: 5},
  {user_id: 9, friend_id: 2},
  {user_id: 9, friend_id: 1},
  {user_id: 9, friend_id: 4},
  {user_id: 9, friend_id: 8},
  {user_id: 9, friend_id: 7},
  {user_id: 9, friend_id: 3},
  {user_id: 9, friend_id: 11},
  {user_id: 3, friend_id: 1},
  {user_id: 3, friend_id: 7},
  {user_id: 8, friend_id: 11},
  {user_id: 8, friend_id: 4},
  {user_id: 10, friend_id: 9},
  {user_id: 2, friend_id: 8},
  {user_id: 11, friend_id: 4},
  {user_id: 5, friend_id: 2},
  {user_id: 5, friend_id: 8},
  {user_id: 12, friend_id: 9},
  {user_id: 12, friend_id: 10},
  {user_id: 13, friend_id: 9},
  {user_id: 14, friend_id: 9},
  {user_id: 10, friend_id: 6}
])
User.create!([
  {name: "Hanna", email: "hanna@hanna", phone: "", password_digest: "$2a$10$h4vnO.n4.wjuav1JW/bC5e/ZcRw4EV1hcl6bJ/ONVnbeYNtui5ttW", status: "active", preference: nil},
  {name: "Judy", email: "judy@judy", phone: "", password_digest: "$2a$10$vkGJEbIn3IJ2t07Jn/5n4eTNiDfv3cseoC9IjdZWxE0.r3L5xuUuu", status: "active", preference: nil},
  {name: "Osama", email: "osama@osama", phone: "", password_digest: "$2a$10$9WSGi2ztFB6ekUaHVoNMv.7ToqhVN4RUVENXXYslATVts2bm9mnkG", status: "active", preference: nil},
  {name: "Derek", email: "derek@derek", phone: "", password_digest: "$2a$10$yY0avciv7.EUIQTTan33y.SXwPbKmVuP/w8efIRllHWvbgpUAjNUG", status: "active", preference: nil},
  {name: "Amanda", email: "amanda@amanda", phone: "", password_digest: "$2a$10$34az8GVPKLIRzWaL1k6r5.ZWGtcD698KVwDRIolVmTYt9XmPejbNW", status: "active", preference: nil},
  {name: "Carlo", email: "carlo@carlo", phone: "", password_digest: "$2a$10$dG5HfeIt3XMhi0RBAQkJt.4/Do/dfH8.Rno/S9We7vX./b8EeZP4a", status: "active", preference: nil},
  {name: "Kelly", email: "kelly@kelly", phone: "3154812601", password_digest: "$2a$10$Zio7j9up76mq4Ji4bYi.4OeAhlGkFglEi5pSm8s/kRV5PnbQqJehS", status: "active", preference: "phone"},
  {name: "Janice", email: "janice@janice", phone: "9176087576", password_digest: "$2a$10$b4GOBZEyMUyvFckY3WrirO0h/su.nzt0VMCcw4Mzu7BgiVh/RSxty", status: "active", preference: "phone"},
  {name: "Neil", email: "neil@neil", phone: nil, password_digest: "$2a$10$Oe0vw9lzplulqsXfijR9zeLUNWYKvttLRQF1Ob4tEAcxTdxV1G5Oi", status: "active", preference: "email"},
  {name: "Kaz", email: "kaz@kaz", phone: "", password_digest: "$2a$10$WvjVUB5zA4SFA8flg33Ib.hGOH/e5lrPRms1NoNmyN7pIlEjZJlvO", status: "active", preference: nil},
  {name: "Sonia", email: "sonia@sonia", phone: "", password_digest: "$2a$10$jDCqo80bsquIdIgNc3zkDuOfQh5rTuQ7vx/3/r/6MdqeWFpSx0WL6", status: "active", preference: nil}
])
