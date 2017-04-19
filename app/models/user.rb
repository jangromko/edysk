class User < ApplicationRecord
  has_many :user_files
  has_many :directories
  belongs_to :account_type
  has_many :shared_files
  has_many :shared_directories
end
