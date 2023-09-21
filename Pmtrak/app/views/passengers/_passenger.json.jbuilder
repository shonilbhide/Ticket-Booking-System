json.extract! passenger, :id, :name, :email, :password, :phone_number, :address, :credit_number, :created_at, :updated_at
json.url passenger_url(passenger, format: :json)
