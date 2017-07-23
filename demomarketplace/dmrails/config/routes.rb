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
  post 'orders/get', to: 'orders#get_do'

  get 'orders/update', to: 'orders#update'
  post 'orders/update', to: 'orders#update_do'
  post 'orders/get', to: 'orders#get_do'

  get 'orders/open', to: 'orders#open'
  post 'orders/open', to: 'orders#open_do'

  get 'orders/close', to: 'orders#close'
  post 'orders/close', to: 'orders#close_do'

  get 'orders/approve', to: 'orders#approve'
  post 'orders/approve', to: 'orders#approve_do'

  get 'orders/reject', to: 'orders#reject'
  post 'orders/reject', to: 'orders#reject_do'
  #-/orders

end
