class Passenger < ApplicationRecord
    has_secure_password
    has_many :tickets, dependent: :destroy
    has_many :reviews, dependent: :destroy

    validates :email, presence: true,format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Please enter valid email address"}, uniqueness: true
    validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/, message: "Please enter valid phone number. Format XXX-XXX-XXXX"}
    validates :credit_number, presence: true, format: { with: /\A\d{4}-\d{4}-\d{4}-\d{4}\z/, message: "Please enter valid card number. Format XXXX-XXXX-XXXX-XXXX" }
end
