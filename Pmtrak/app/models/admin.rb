class Admin < ApplicationRecord
    include SingleInstanceModel
    has_secure_password
    validates :credit_number, presence: true, format: { with: /\A\d{10}\z/ }
    validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/ }

    
end
