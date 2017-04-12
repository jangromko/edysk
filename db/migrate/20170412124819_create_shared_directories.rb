class CreateSharedDirectories < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :directories, table_name: :shared_directories do |t|
      t.index :directory_id
      t.index :user_id
      t.timestamps
    end
  end
end
