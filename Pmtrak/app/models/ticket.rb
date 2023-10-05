class Ticket < ApplicationRecord
    belongs_to :train
    belongs_to :passenger
    before_create :generate_confirmation_number

  private

  def generate_confirmation_number
    confirmation_string = (Time.now.to_i-passenger_id-train_id).to_s
    self.confirmation_number = confirmation_string
  end
end
