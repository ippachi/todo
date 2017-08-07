Rails.application.routes.draw do
  devise_for :users

  resources :users do 
    resource :tasks, only:[:update]
    resources :tasks
  end


  root 'home#index'
end
