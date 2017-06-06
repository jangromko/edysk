class AddUsedPlaceAndFileSize < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :used_size, :integer
    add_column :user_files, :size, :integer
  end
end
