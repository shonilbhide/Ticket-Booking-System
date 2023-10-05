class Admin < ApplicationRecord
    include SingleInstanceModel
    has_secure_password
    validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/ }
    validates :credit_number, presence: true, format: { with: /\A\d{4}-\d{4}-\d{4}-\d{4}\z/ }
    validates :email, presence: true
end
