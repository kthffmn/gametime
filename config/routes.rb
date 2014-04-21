Rails.application.routes.draw do
  
  # angular
  get '/games-angular', :to => redirect('/app/index.html#/games')
  get '/404-angular', :to => redirect('app/index.html#/404')
  
  # games
  resources :games

end
