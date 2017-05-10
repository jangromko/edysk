json.extract! admin_user, :id, :login, :email, :password, :salt, :account_type_id, :created_at, :updated_at, :created_at, :updated_at
json.url admin_user_url(admin_user, format: :json)
