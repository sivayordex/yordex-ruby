Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'welcome/index', to: 'welcome#index'
  get 'say_hello/sona', to: 'your_controller#your_action'

end
