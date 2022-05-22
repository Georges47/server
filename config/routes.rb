Rails.application.routes.draw do
  get '/youtube-dl/process', to: 'youtube_dl#download'
  get '/youtube-dl/song', to: 'youtube_dl#send_song'

  mount ActionCable.server => '/cable'
end