Rails.application.routes.draw do

  get "/" => "home#top"
  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"
  get "userpage" => "users#show"

  get "about" => "home#about"
  get "calendar" => "calendar#top"

  get "trade/index" => "trade#index"
  get "trade/new" => "trade#new"
  post "trade/create" => "trade#create"
  get "trade/:id" => "thread#new"

  
  get "thread/:id/new" => "thread#new"
  post "thread/:id/create" => "thread#create"
  #get "/event" => "event#top"

  post "users/create" => "users#create"
  get "signup" => "users#new"

end
