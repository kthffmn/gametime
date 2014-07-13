Rails.application.routes.draw do
  
  # root/home
  root 'static_pages#home'

  # static pages
  get '/about',       to: 'static_pages#about'
  get '/contact',     to: 'static_pages#contact'

  # sessions
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # angular
  get '/games-angular', to: redirect('/app/index.html#/games')
  get '/404-angular',   to: redirect('app/index.html#/404')
  
  # games
  resources :games

end
