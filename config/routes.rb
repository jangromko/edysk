Rails.application.routes.draw do

  get 'dir/shared/:hash', to: 'dir#shared', hash: /[A-Za-z0-9]\d{32}/
  get 'dir/shared'
  post 'dir/move'
  get 'dir/show/:id', to: 'dir#show', id: /[0-9]+/
  put 'dir/new'
  delete 'dir/remove'
  post 'dir/name'
  post 'dir/unshare'

  get 'file/download/:id', id: /[0-9]+/, to: 'file#download'
  get 'file/shared'
  get 'file/shared/:hash', hash: /[A-Za-z0-9]\d{32}/, to: 'file#shared'
  delete 'file/remove'
  post 'file/name'
  post 'file/share'
  post 'file/move'
  post 'file/copy'
  put 'file/upload'
  post 'file/unshare'

  root to: 'public#home'
  get 'drive', to: 'main#drive'


  namespace :public do
    get 'public_controller/home'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
