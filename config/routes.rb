Rails.application.routes.draw do
  
  # root/home
  root 'games#index'

  # angular
  get '/games-angular', :to => redirect('/app/index.html#/games')
  get '/404-angular', :to => redirect('app/index.html#/404')
  
  # games
  resources :games

end
