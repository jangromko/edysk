class MainController < ApplicationController
  layout "drive"
  before_action :authorization
  def drive
    @root_directory =  Directory.find(User.find(user_id).root_directory_id)
  end

  def authorization
    raise NotPermitted if session[:user_id].nil?
  end
  private
    def user_id
      session[:user_id]
    end
end
