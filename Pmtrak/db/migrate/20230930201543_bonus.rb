class Bonus < ActiveRecord::Migration[6.1]

  def change
    add_reference :tickets, :creator, index: true, foreign_key: { to_table: :passengers }
  end
end