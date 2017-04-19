class UserFile < ApplicationRecord
  belongs_to :user
  belongs_to :directory
  has_many :shared_files
end
