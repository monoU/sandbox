Rails.application.routes.draw do
  resources :expansions, except: [:show]

  resources :cards, except: [:show] do
    collection do
      post :search
      post :import
      post :destroy_all
    end
  end

  root :to => 'index#top'
end
