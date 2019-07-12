class AddVerificationTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :verification_token, :string
  end
end
