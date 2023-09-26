class Review < ApplicationRecord
    belongs_to :passenger
    belongs_to :train
    validates :rating, presence: true
end
