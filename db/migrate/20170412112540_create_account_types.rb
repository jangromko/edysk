class CreateAccountTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :account_types do |t|
      t.string :name
      t.integer :space
      t.integer :price

      t.timestamps
    end
  end
end
