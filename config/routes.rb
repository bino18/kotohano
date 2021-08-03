Rails.application.routes.draw do
  resources :posts
  resources :users

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  get '/',  to: 'top#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
