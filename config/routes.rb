CheckIn::Application.routes.draw do

  post 'twilio/voice' => 'twilio#voice'

  get 'twilio/sms' => 'twilio#sms'

end
