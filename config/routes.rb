Rails.application.routes.draw do
  get "cards/index"
  resources :cards do
    collection do
      post :import
    end
  end

  root :to => 'index#top'
end
