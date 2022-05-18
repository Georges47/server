Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/youtube-dl', to: 'youtube_dl#form'
  get '/download_link', to: 'youtube_dl#download_link'
  get '/song', to: 'youtube_dl#send_song'

end