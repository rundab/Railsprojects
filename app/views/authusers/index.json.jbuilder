json.array!(@authusers) do |authuser|
  json.extract! authuser, :id
  json.url authuser_url(authuser, format: :json)
end
