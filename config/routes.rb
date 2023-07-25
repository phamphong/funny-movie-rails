Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
  # Defines the root path route ("/")
  # root "articles#index"

  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  post 'auth/logout', to: 'users#logout'
  get 'auth/user-info', to: 'users#userInfo'

  post 'movie/share', to: "movies#share"
  get 'movie/all', to: "movies#all"
  post 'movie/search', to: "movies#search"

end
