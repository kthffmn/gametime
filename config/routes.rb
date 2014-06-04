Rails.application.routes.draw do
  
  # root/home
  root 'static_pages#home'

  # static pages
  get '/home',       to: 'static_pages#home'
  get '/about',       to: 'static_pages#about'
  get '/contact',     to: 'static_pages#contact'

  # angular
  get '/games-angular', to: redirect('/app/index.html#/games')
  get '/404-angular',   to: redirect('app/index.html#/404')
  
  # games
  resources :games

end
