Rails.application.routes.draw do

  get 'dir/shared/:hash', to: 'dir#shared', hash: /[A-Za-z0-9]\d{32}/
  get 'dir/shared'
  post 'dir/move'
  get 'dir/show/:dir_id', to: 'dir#show', dir_id: /[0-9]+/
  put 'dir/new'
  delete 'dir/remove'
  post 'dir/name'
  post 'dir/unshare'

  get 'file/download/:file_id', file_id: /[0-9]+/, to: 'file#download'
  get 'file/shared/:hash', hash: /[A-Za-z0-9]+/, to: 'file#shared_file'
  get 'file/shared'
  delete 'file/remove'
  post 'file/name'
  post 'file/share'
  post 'file/move'
  post 'file/copy'
  put 'file/upload'
  post 'file/unshare'
  post 'file/publish'
  get 'file/extensions_list'
  get 'registration', to: 'public#registration'
  post 'registration', to: 'public#registration'
  get 'forgot_password', to: 'public#forgot_password'
  post 'forgot_password', to: 'public#forgot_password'
  get 'recover_password/:hash', to: 'public#recover_password', as: "recover_password"
  post 'recover_password/:hash', to: 'public#recover_password'
  root to: 'public#home'
  get 'drive', to: 'main#drive'
  get 'logout', to: 'public#logout'

  post 'login', to: 'public#login'

  namespace :admin do
    resources :users, :account_types
  end

  get 'users/index', to: 'users#index'
  get 'users/show', to: 'users#show'
  get 'account_types/index', to: 'account_types#index'
 # get 'account_types/show', to: 'account_types#show'

  namespace :public do
    get 'public_controller/home'
    get 'public_controller/registration'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
