Rails.application.routes.draw do
  devise_for :users
  resources :users do 
    member do
      get :tasks
    end
  end
  root 'home#index'
end
