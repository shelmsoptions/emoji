Rails.application.routes.draw do
  resources:main

  root 'main#index'

  post '/main' => 'main#get_api'

  get '/interpretation' => 'main#get_api'

  post '/back' => 'main#back'
end