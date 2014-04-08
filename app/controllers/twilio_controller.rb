require 'twilio-ruby'
require 'chronic'
class TwilioController < ApplicationController
  include SentimentHelper
  include Webhookable
 
  after_filter :set_header

  def create
    alchemy_general_sentiment(params[:text], current_user.id)
  end

  def schedule
    Schedule.create(user_id: current_user.id, schedule: Chronic.parse(params[:text])) 
    @schedule_delay = Time.now - Schedule.where(user_id: current_user.id).last.schedule
    @current_user_phone = User.find(current_user.id).phone
    MyWorker.perform_in(@schedule_delay.seconds, @current_user_phone) 
  end
 
  def voice

    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Thank you for calling pocket rant! We can only accept text entries, thank you.', :voice => 'alice'
         r.Play 'http://linode.rabasa.com/cantina.mp3'
    end
 
    render_twiml response
  end

  def sms
    @twilio_client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @message_content = params[:Body]
    @message_sender_phone = params[:From]
    @user_id = User.find_by(phone: @message_sender_phone.to_i).id 

    twilio_phone_number = "6467626027"

    alchemy_general_sentiment(@message_content, @user_id)

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => @message_sender_phone,
      :body => "Your thoughts have been recorded. Thank you."
    )
  end

end