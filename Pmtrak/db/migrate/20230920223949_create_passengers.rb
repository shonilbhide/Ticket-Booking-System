class CreatePassengers < ActiveRecord::Migration[6.1]
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :phone_number
      t.string :address
      t.string :credit_number

      t.timestamps
    end
  end
end
