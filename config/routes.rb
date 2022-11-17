Rails.application.routes.draw do
  get "/" => "home#top"
  get "/about" => "home#about"
  get "/calender" => "calender#top"
  get "/trade" => "trade#top"

  # Defines the root path route ("/")
  # root "articles#index"
end
