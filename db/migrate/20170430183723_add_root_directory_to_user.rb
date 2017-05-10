class AddRootDirectoryToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :root_directory_id, :integer
    add_foreign_key :users, :directories, column: :root_directory_id
  end
end
