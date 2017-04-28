class PublicController < ApplicationController
  def home
  end

  def registration

    if request.post?
      @user = User.new(params.require(:user).permit(:login, :password, :password_confirmation, :email))
      @user.account_type = AccountType.find(1)
      if @user.valid?
        flash[:success] = "Zarejestrowano poprawnie!"
        @user.save!
        redirect_to "/"
      end
    else
      @user = User.new
    end

  end
end
