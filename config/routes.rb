Rails.application.routes.draw do
  devise_for :users

  resources :users do 
    resources :tasks
  end


  root 'home#index'
end
