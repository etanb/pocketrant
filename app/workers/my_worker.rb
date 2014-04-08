class MyWorker
  include Sidekiq::Worker
  
  def perform(phone)
    @twilio_client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    twilio_phone_number = "6467626027"
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => "+#{phone}",
      :body => "Good morning. Now, tell me what your dreams were about by starting your text with #dream:"
    )
  end
end