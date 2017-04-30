class PublicController < ApplicationController
  def home
  end

  def forgot_password
    if request.post?
      user_params = params.require(:forgotten_password_form).permit(:login, :email)
      form = ForgottenPasswordForm.new user_params
      if form.valid?
        user = User.find_by_email(user_params[:email])
        hash = SecureRandom.hex
        if user.login.eql? user_params[:login]
          forgotten_password = ForgottenPassword.new(user: user, hash_pk: hash)
          until forgotten_password.save
            forgotten_password.hash_pk = SecureRandom.hex
          end
        end
        render "forgotten_password_part2"
      else
        @forgotten_password = form
        render "forgot_password"
      end

    else
      @forgotten_password = ForgottenPasswordForm.new
    end
  end
  def registration

    if request.post?
      @user = User.new(params.require(:user).permit(:login, :password, :password_confirmation, :email))
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
