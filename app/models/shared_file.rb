class SharedFile < ApplicationRecord
  belongs_to :user
  belongs_to :user_file
end
