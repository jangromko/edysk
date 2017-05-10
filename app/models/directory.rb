class Directory < ApplicationRecord
  belongs_to :user
  belongs_to :directory, required: false
  has_many :shared_directories
end
