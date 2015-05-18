json.array!(@auth_users) do |auth_user|
  json.extract! auth_user, :id, :name, :hashed_password, :level
  json.url auth_user_url(auth_user, format: :json)
end
