class AddKeyToReview < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :passenger, null: false, foreign_key: true
    add_reference :reviews, :train, null: false, foreign_key: true
  end
end
