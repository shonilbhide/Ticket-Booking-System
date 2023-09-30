class Train < ApplicationRecord
    has_many :tickets, dependent: :destroy
    has_many :reviews, dependent: :destroy
    validates :train_number, presence: true, uniqueness: true
    validates :seats_left, numericality: { greater_than: 0 }


    def average_rating
        reviews.average(:rating).to_f.round(2)
    end
end
