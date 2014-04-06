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

  def alchemy_ranked_keywords(string)
    options = {:query => {:apikey => '8cda6697e241a8ea3b13eda9e3851dd953d462bf',
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
    options = {:query => {:apikey => '8cda6697e241a8ea3b13eda9e3851dd953d462bf',
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