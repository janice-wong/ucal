json.array!(@invitations) do |invitation|
  if invitation.user == current_user
    json.title invitation.event.name
    json.start invitation.event.start
    json.end invitation.event.end
    json.user invitation.user.name
  else
    json.title ""
    json.start invitation.event.start
    json.end invitation.event.end
    json.user invitation.user.name
  end
end
