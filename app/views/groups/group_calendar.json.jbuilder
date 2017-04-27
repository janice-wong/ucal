json.array!(@invitations) do |invitation|
  json.title invitation.event.name
  json.start invitation.event.start
  json.end invitation.event.end
  json.user invitation.user.name
end