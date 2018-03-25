Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  resources :expansions, except: [:show]

  resources :cards, except: [:show] do
    collection do
      get :search
      post :search, :import, :destroy_all
    end
  end

  root 'home#index'
end
