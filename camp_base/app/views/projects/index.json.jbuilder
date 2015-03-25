json.array!(@projects) do |project|
  json.extract! project, :id, :name, :due_on, :owner_id
  json.url project_url(project, format: :json)
end
