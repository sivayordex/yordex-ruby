Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'welcome/index', to: 'welcome#index'

  post 'apikey/set', to: 'apikey#set'

  #orders
  get 'orders/index', to: 'orders#index'

  get 'orders/create', to: 'orders#create'
  post 'orders/create', to: 'orders#create_do'

  get 'orders/get', to: 'orders#get'
  get 'orders/get_', to: 'orders#get_do'

  get 'orders/update', to: 'orders#update'
  post 'orders/update', to: 'orders#update_do'

  get 'orders/open', to: 'orders#open'
  post 'orders/open', to: 'orders#open_do'

  get 'orders/close', to: 'orders#close'
  post 'orders/close', to: 'orders#close_do'

  get 'orders/approve', to: 'orders#approve'
  post 'orders/approve', to: 'orders#approve_do'

  get 'orders/reject', to: 'orders#reject'
  post 'orders/reject', to: 'orders#reject_do'

  get 'orders/event', to: 'orders#event'
  post 'orders/event', to: 'orders#event_do'
  #-/orders

  #ads
  get 'ads/index', to: 'ads#index'

  get 'ads/get', to: 'ads#get'
  get 'ads/get_', to: 'ads#get_do'

  get 'ads/enable', to: 'ads#enable'
  post 'ads/enable', to: 'ads#enable_do'

  get 'ads/disable', to: 'ads#disable'
  post 'ads/disable', to: 'ads#disable_do'
  #-/ads

  #traders
  get 'traders/index', to: 'traders#index'

  get 'traders/create', to: 'traders#create'
  post 'traders/create', to: 'traders#create_do'

  get 'traders/update', to: 'traders#update'
  post 'traders/update', to: 'traders#update_do'
  #-/traders

  #sso
  get 'sso/index', to: 'sso#index'

  get 'sso/get', to: 'sso#get'
  post 'sso/get', to: 'sso#get_do'
  #-/sso

end
