class UniqueIndexInSharedFilesAndDirectories < ActiveRecord::Migration[5.1]
  def change
    add_index :shared_files, [:user_id, :user_file_id], unique: true
    add_index :shared_directories, [:user_id, :directory_id], unique: true
  end
end
