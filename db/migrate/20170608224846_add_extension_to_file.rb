class AddExtensionToFile < ActiveRecord::Migration[5.1]
  def change
    add_column :user_files, :extension, :string
  end
end
