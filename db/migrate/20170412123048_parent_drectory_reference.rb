class ParentDrectoryReference < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :directories, :directories
  end
end
