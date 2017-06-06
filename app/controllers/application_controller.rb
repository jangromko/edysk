class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from NotPermitted, with: :not_permitted

  def not_permitted
    render :file => 'public/400.html',
           :layout => false,
           :status => 400
    return
  end
end
