class MainController < ApplicationController
  layout "drive"
  before_action :authorization
  def drive
    user = User.find(user_id)
    @root_directory =  Directory.find(user.root_directory_id)
    @used = user.used_size
    @max_space = user.account_type.space
  end

  def authorization
    raise NotPermitted if session[:user_id].nil?
  end
  private
    def user_id
      session[:user_id]
    end
end
