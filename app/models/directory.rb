class Directory < ApplicationRecord
  belongs_to :user
  belongs_to :directory, required: false
  has_many :shared_directories
  has_many :user_files
  has_many :directories, :foreign_key => :directory_id, :class_name =>  "Directory"
end
