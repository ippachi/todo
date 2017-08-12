Rails.application.routes.draw do
  devise_for :users

  resources :users,only:[] do 
    resource :tasks, only:[:update] do
      get "/search", to: "tasks#search"
    end
    resources :tasks 
  end

  root 'home#index'

end
