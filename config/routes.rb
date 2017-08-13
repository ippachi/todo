Rails.application.routes.draw do
  devise_for :users

  resources :users,only:[] do 
    resource :tasks, only:[] do
      collection do
        put "/update_state", to: "tasks#update_state"
        patch "/update_state", to: "tasks#update_state"
        get "/search", to: "tasks#search"
      end
    end
    resources :tasks 
  end

  root 'home#index'

end
