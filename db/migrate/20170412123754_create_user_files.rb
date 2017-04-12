class CreateUserFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_files do |t|
      t.string :name
      t.integer :user_id
      t.integer :directory_id
      t.string :link
      t.timestamps
    end

    add_foreign_key :user_files, :directories
    add_foreign_key :user_files, :users
  end
end
