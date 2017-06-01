class UniqueIndexOnPairParentDirectoryAndId < ActiveRecord::Migration[5.1]
  def change
    add_index :directories, [:directory_id, :name], unique: true
  end
end
