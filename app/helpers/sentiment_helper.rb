require 'httparty'
module SentimentHelper

  def alchemy_general_sentiment(string, user)
    message = string.downcase
    options = {:query => {:apikey => 'd41c808cbfcdaa82ce616710ac6c58980c18c1a5',
      :text => message,
      :outputMode => 'json'} }
      response = HTTParty.get("http://access.alchemyapi.com/calls/text/TextGetTextSentiment", options)
    if message.split(" ").first == "#dream"
      Dream.create(
        {text: message, sentiment: response["docSentiment"]["score"], user_id: user}
        )
    else
      Message.create(
        {text: message, sentiment: response["docSentiment"]["score"], user_id: user}
        )
    end
  end

  def alchemy_ranked_keywords(string)
    options = {:query => {:apikey => 'd41c808cbfcdaa82ce616710ac6c58980c18c1a5',
      :text => string,
      :outputMode => 'json'} }
      response = HTTParty.get("http://access.alchemyapi.com/calls/text/TextGetRankedKeywords", options)


    text_keywords = response["keywords"].map {|keyword| keyword["text"]}

    text_keywords.each_with_index do |keyword, index| 
      text_keywords[index] << " " + alchemy_targeted_sentiment(string, keyword) 
    end

    return text_keywords

  end



  def alchemy_targeted_sentiment(string, keyword)
    options = {:query => {:apikey => 'd41c808cbfcdaa82ce616710ac6c58980c18c1a5',
      :text => string,
      :target => keyword,
      :outputMode => 'json'} }
      response = HTTParty.get("http://access.alchemyapi.com/calls/text/TextGetTargetedSentiment", options)

    if response["status"] == "ERROR"
      return response["status"]
    else
      return response["docSentiment"]["score"]
    end

  end

end