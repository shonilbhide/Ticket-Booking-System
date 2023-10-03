class Train < ApplicationRecord
    has_many :tickets, dependent: :destroy
    has_many :reviews, dependent: :destroy
    validates :train_number, presence: true, uniqueness: true
    validates :seats_left, numericality: { greater_than_or_equal_to: 0  }
    validates :train_capacity, numericality: { greater_than: 0 ,greater_than_or_equal_to: :seats_left}
    validates :ticket_price, numericality: { greater_than: 0 }


    def average_rating
        reviews.average(:rating).to_f.round(2)
    end
end
