require 'twilio-ruby'
class TwilioController < ApplicationController
  include SentimentHelper
  include Webhookable
 
  after_filter :set_header
 
  def voice

    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
         r.Play 'http://linode.rabasa.com/cantina.mp3'
    end
 
    render_twiml response
  end

  def sms
    @twilio_client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @message_content = params[:Body]
    @message_sender_phone = params[:From]
 

    twilio_phone_number = "6467626027"

    alchemy_general_sentiment(@message_content)

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => @message_sender_phone,
      :body => "Your feelings have been recorded. Thank you!"
    )
  end




  # TWILIO_PHONE_NUMBER = '6467626027'
  # @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
  
  # def outgoing

  #   @client.account.messages.create(
  #     :from => "+1#{TWILIO_PHONE_NUMBER}",
  #     :to => '+16467524876',
  #     :body => 'Hey there!'
  #   )
    
  # end
end