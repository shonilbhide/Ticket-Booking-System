class Ticket < ApplicationRecord
    belongs_to :train
    belongs_to :passenger
end
