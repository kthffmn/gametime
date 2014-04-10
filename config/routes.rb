Rails.application.routes.draw do

  resources :games do
    resources :names
  end

end
