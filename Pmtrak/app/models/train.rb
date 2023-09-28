class Train < ApplicationRecord
    has_many :tickets
    has_many :reviews, dependent: :destroy
end
