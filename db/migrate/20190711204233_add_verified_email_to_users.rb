class AddVerifiedEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :verified_email, :boolean, default: false
  end
end
