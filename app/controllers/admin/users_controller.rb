class Admin::UsersController < ApplicationController
  before_action :set_admin_user, only: [:show, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @admin_users = User.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end


  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    User.transaction do
      @admin_user.root_directory_id = nil
      @admin_user.save
      @admin_user.directories.destroy_all
      @admin_user.destroy
    end
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:admin_user).permit(:login, :email, :password, :salt, :account_type_id, :created_at, :updated_at)
    end
end
