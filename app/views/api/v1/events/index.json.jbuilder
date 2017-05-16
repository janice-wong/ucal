json.array!(@accepted_events) do |event|
  json.extract! event, :start, :end
  json.title event.name
  json.url "/events/#{event.id}"
end