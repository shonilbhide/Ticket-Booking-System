class ChangePasswordColumns < ActiveRecord::Migration[6.1]
  def change
    change_column :passengers, :password, :password_digest
    change_column :admins, :password, :password_digest
  end
end
