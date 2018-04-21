Rails.application.routes.draw do
  resources :expansions, except: [:show]

  resources :cards, except: [:show] do
    collection do
      get :search
      post :search, :import, :destroy_all
    end
  end

  root :to => 'index#top'
end
