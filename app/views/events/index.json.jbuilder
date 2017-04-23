json.array!(@accepted_events) do |event|
  json.extract! event, :name, :start, :end
  json.url event_url(event, format: :html)
end