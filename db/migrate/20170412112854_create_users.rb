class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :password
      t.string :salt
      t.integer :account_type_id
      t.timestamps
    end
  end
end
