class UserFile < ApplicationRecord
  belongs_to :user
  belongs_to :directory
  has_many :shared_files
  validates :name, presence: true, format: { with: /[a-zA-Z0-9]+/}
end
