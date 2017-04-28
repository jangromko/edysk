class UniqueIndexOnPairDirectoryAndFileName < ActiveRecord::Migration[5.1]
  def change
    add_index :user_files, [:directory_id, :name]
  end
end
