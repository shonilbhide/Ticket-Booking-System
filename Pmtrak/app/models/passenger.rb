class Passenger < ApplicationRecord
    has_secure_password
    has_many :tickets, dependent: :destroy
    has_many :reviews, dependent: :destroy

    validates :email, presence: true,format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }, uniqueness: true
    validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/ }
    validates :credit_number, presence: true, length: { maximum: 255 }
end
