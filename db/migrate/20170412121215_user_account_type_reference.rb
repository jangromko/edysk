class UserAccountTypeReference < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :users, :account_types
  end
end
