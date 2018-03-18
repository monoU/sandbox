Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  resources :expansions, except: [:show]

  resources :cards, except: [:show] do
    collection do
      post :search
      post :import
      post :destroy_all
    end
  end

  root 'home#index'
end
