Rails.application.routes.draw do
  get 'home/index'

  resources :expansions, except: [:show]

  resources :cards, except: [:show] do
    collection do
      get :search
      post :search, :import, :destroy_all
    end
  end

  root :to => 'home#index'
end
