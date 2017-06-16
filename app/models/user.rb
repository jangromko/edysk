require 'digest'
class User < ApplicationRecord
  validates :password, confirmation: true, length: {minimum: 8}
  validates :login, :password, presence: true
  validates :login, length: {minimum: 5},  uniqueness: true
  validates :login, format: { with: /[a-z0-9\-]+/, message: "może zawierać tylko małe litery alfabetu łacińskiego, liczby i znak \"-\""}
  validates :email, presence: true, uniqueness: true

  before_update do |user|
    if user.password_changed?
      hash_password(user)
    end
  end

  before_create do |user|
    hash_password(user)
  end

  def self.authenticate(login, password)
    user = self.find_by_login(login)
    return nil if user.nil?

    return user.id if user.password.eql?(Digest::SHA2.new(512).hexdigest(user.salt+password))
    return nil
  end

  def hash_password(user)
    user.salt = SecureRandom.hex
    user.password = Digest::SHA2.new(512).hexdigest(user.salt + user.password)
    user.password_confirmation = user.password
  end

  has_one :directory, as: :root_directory, autosave: true
  has_many :user_files
  has_many :directories, autosave: true
  belongs_to :account_type, optional: true
  has_many :shared_files
  has_many :shared_directories
end
