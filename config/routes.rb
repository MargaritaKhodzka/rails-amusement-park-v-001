Rails.application.routes.draw do

  resources :users
  resources :attractions

  root 'welcome#home'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  post '/rides/new' => 'rides#new'

end
