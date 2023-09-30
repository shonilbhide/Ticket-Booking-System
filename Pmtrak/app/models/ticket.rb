class Ticket < ApplicationRecord
    belongs_to :train
    belongs_to :passenger
    before_create :generate_confirmation_number

  private

  def generate_confirmation_number
    confirmation_string = "#{train_id}-#{passenger_id}-#{Time.now.to_i}"
    self.confirmation_number = Digest::SHA256.hexdigest(confirmation_string)
  end
end
