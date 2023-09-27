class ChangePassengerPassword < ActiveRecord::Migration[6.1]
  def change
    remove_column :passengers, :password
    add_column :passengers, :password_digest, :string
  end
end
