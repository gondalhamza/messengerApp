Rails.application.routes.draw do
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'callback/index'
  get '/client', to: 'callback#client'
  post 'chat', to: 'callback#chat'
  get 'callback/received_data'
  post '/' => 'callback#received_data'
  
  post 'send_message', to: 'callback#send_message'
  root 'callback#index'
  
  mount Facebook::Messenger::Server, at: "bot"
end