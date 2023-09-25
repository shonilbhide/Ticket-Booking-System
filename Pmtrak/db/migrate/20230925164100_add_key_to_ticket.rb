class AddKeyToTicket < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :passenger, null: false, foreign_key: true
    add_reference :tickets, :train, null: false, foreign_key: true
  end
end
