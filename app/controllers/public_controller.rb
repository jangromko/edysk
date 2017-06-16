class PublicController < ApplicationController
  def home
  end

  def forgot_password
    if request.post?
      user_params = params.require(:forgotten_password_form).permit(:login, :email)
      form = ForgottenPasswordForm.new user_params
      if form.valid?
        user = User.find_by_email(user_params[:email]) || User.new
        hash = SecureRandom.hex
        if user.login.eql? user_params[:login]
          forgotten_password = ForgottenPassword.new(user: user, hash_pk: hash)
          until forgotten_password.save
            forgotten_password.hash_pk = SecureRandom.hex
          end
          EdyskMailer.new.send(user.email, "Odzyskiwanie hasła", "Dzień dobry, #{user.login}!\nDla tego konta zażądano zmiany hasła. Jeżeli to ty chciałeś je zmienić, kliknij tu: #{recover_password_url(hash)}. \n Pozdrawiamy -\nZespół Edysk\n-----------\nŻądanie wygenerowano #{Time.now.strftime("%d/%m/%Y %H:%M")} z ip: #{request.remote_ip}")
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

  def recover_password
    fp = ForgottenPassword.where("used=FALSE and hash_pk=?", params.require(:hash))
    if fp.any?
      fp = fp[0]
      if request.post?
        @recover_password = RecoverPassword.new(params.require(:password).permit(:password, :password_confirmation))
        if @recover_password.valid?
          user = fp.user
          user.password = params.require(:password).permit(:password)[:password]
          User.transaction do
            user.save!
            fp.used = true
            fp.save!
          end
          redirect_to root_url
        end
      else
        @recover_password = RecoverPassword.new
      end
    else
      render :status => 404,
             :plain => 'Not found'
    end
  end
  def registration

    if request.post?
      @user = User.new(params.require(:user).permit(:login, :password, :password_confirmation, :email))
      @user.account_type_id = AccountType.minimum(:id)
      @user.used_size = 0
      if @user.valid?
        User.transaction do
          @user.save!
          directory = Directory.new name: "root", user: @user, user_id: @user.id
          directory.save!
          @user.root_directory_id = directory.id
          @user.save!
        end
        EdyskMailer.new.send(@user.email, "Witamy na edysku!", "Dzień dobry, #{@user.login}!\nWitamy w Edysku! Poznaj już dziś wszystkie możliwości i bezpiecznie przechowuj swoje dane, mając do nich dostęp z każdego miejsca. \nPozdrawiamy –\nZespół Edysk")
        flash[:success] = "Zarejestrowano poprawnie!"
        redirect_to root_url
      end
    else
      @user = User.new
    end

  end

  def login
    user_params = params.require(:user).permit(:login, :password)
    id = User.authenticate(user_params[:login], user_params[:password])
    if id.nil?
      flash[:error] = "Zły identyfikator/złe hasło"
      redirect_to root_url
    else
      session[:user_id] = id
      redirect_to drive_url
    end
  end

  def logout
    session.delete :user_id
    redirect_to root_url
  end

end
