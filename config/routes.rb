Rails.application.routes.draw do
  root to: 'public#home'
  get 'drive', to: 'main#drive'


  namespace :public do
    get 'public_controller/home'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
