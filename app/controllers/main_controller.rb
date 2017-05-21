class MainController < ApplicationController
  layout "drive"
  def drive
    @root_directory =  Directory.find(User.find(user_id).root_directory_id)
  end

  private
    def user_id
      User.maximum(:id)
    end
end
