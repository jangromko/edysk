class CreateDirectories < ActiveRecord::Migration[5.1]
  def change
    create_table :directories do |t|
      t.string :name
      t.integer :user_id
      t.integer :directory_id
      t.string :link

      t.timestamps
    end

    add_foreign_key :directories, :users
  end
end
