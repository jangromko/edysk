class CreateTableForgottenPassword < ActiveRecord::Migration[5.1]
  def change
    create_table :forgotten_passwords, id: false do |t|
      t.primary_key :hash, :string
      t.integer :user_id, null: false
      t.boolean :used, null: false, default: false
      t.timestamps
    end
    add_foreign_key :forgotten_passwords, :users, column: :user_id
  end
end
