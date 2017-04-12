class CreateSharedFiles < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :user_files, table_name: :shared_files do |t|
      t.index :user_file_id
      t.index :user_id
      t.timestamps
    end
  end
end
