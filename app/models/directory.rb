class Directory < ApplicationRecord
  validates_presence_of :name
  validates :name, format: { with: /[a-zA-Z0-9]+/}
  validates_uniqueness_of :name, scope: :directory_id
  belongs_to :user
  belongs_to :directory, required: false
  has_many :shared_directories
  has_many :user_files
  has_many :directories, :foreign_key => :directory_id, :class_name =>  "Directory"
end
