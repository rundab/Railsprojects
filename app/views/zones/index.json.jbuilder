json.array!(@zones) do |zone|
  json.extract! zone, :id, :name, :sqft, :hour_limit, :meter_pct, :event_id
  json.url zone_url(zone, format: :json)
end
