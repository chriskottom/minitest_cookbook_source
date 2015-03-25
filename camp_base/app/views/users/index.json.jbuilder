json.array!(@users) do |user|
  json.extract! user, :id, :login, :password_digest
  json.url user_url(user, format: :json)
end
