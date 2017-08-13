Rails.application.routes.draw do
  devise_for :users

  resource :tasks, only:[] do
    collection do
      put "/update_state", to: "tasks#update_state"
      patch "/update_state", to: "tasks#update_state"
      get "/search", to: "tasks#search"
    end
  end

  resources :tasks

  root 'home#index'

end
