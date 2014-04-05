CheckIn::Application.routes.draw do

  devise_for :users

  resources :users

  post 'twilio' => 'twilio#create'

  post 'twilio/voice' => 'twilio#voice'

  get 'twilio/sms' => 'twilio#sms'

  root :to => "welcome#index"

end
