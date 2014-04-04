require 'httparty'
module SentimentHelper
  
  def alchemy_general_sentiment(string)
    message = string.downcase
    options = {:query => {:apikey => '8cda6697e241a8ea3b13eda9e3851dd953d462bf',
                          :text => message,
                          :outputMode => 'json'} }
    response = HTTParty.get("http://access.alchemyapi.com/calls/text/TextGetTextSentiment", options)

    Message.create(
      {text: message, sentiment: response["docSentiment"]["score"]}
        )
  end

end