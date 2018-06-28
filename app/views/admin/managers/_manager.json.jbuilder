json.extract! manager, :id, :email, :full_name, :password, :password_confirmation, :created_at, :updated_at
json.url manager_url(manager, format: :json)
