require File.dirname(__FILE__) + '/../uploaders/user_file_uploader'
class UserFile < ApplicationRecord
  belongs_to :user
  belongs_to :directory
  has_many :shared_files
  validates :name, presence: true, format: { with: /[a-zA-Z0-9]+/}
  validates_uniqueness_of :name, :scope => :directory_id
  mount_base64_uploader :file, UserFileUploader
end
