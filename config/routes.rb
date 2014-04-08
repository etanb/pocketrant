CheckIn::Application.routes.draw do

  # require 'sidekiq/web'
  # resources :snippets
  # root to: "snippets#new"
  # mount Sidekiq::Web, at: "/sidekiq"
  

  devise_for :users

  resources :users

  post 'twilio' => 'twilio#create'

  post 'twilio/voice' => 'twilio#voice'

  post 'twilio/schedule' => 'twilio#schedule'

  get 'twilio/sms' => 'twilio#sms'

  root :to => "welcome#index"

end
