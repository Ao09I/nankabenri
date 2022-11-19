Rails.application.routes.draw do
  get 'calendar/top'
  get 'event/top'
  get "/" => "home#top"
  get "/about" => "home#about"
  get "/calendar" => "calendar#top"
  get "/trade" => "trade#top"
  get "/event" => "event#top"

  # Defines the root path route ("/")
  # root "articles#index"
end
