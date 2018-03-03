Rails.application.routes.draw do
  get "cards/index"
  resources :cards do
    collection do
      post :find
      post :import
      post :destroy_all
    end
  end

  root :to => 'index#top'
end
