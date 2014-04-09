require 'spec_helper'
include SentimentHelper

describe SentimentHelper do
  describe "#alchemy_general_sentiment" do

    it "posts the message to the database with a sentiment score" do
      dream_count = Dream.all.count
      alchemy_general_sentiment("#dream I love dragons!", 1)
      new_dream_count = Dream.all.count
      expect(new_dream_count).to eql(dream_count + 1)
    end

    it "has hashtagDream and then posts the dream to the database with a sentiment score" do
      message_count = Message.all.count
      alchemy_general_sentiment("I love taking strolls in central park!", 1)
      new_message_count = Message.all.count
      expect(new_message_count).to eql(message_count + 1)
    end
  end

  describe "#alchemy_ranked_keywords" do
    it "returns the keywords from user input in sentiment order" do
      expect(alchemy_ranked_keywords("I love my dog.")).to eql(["dog 0.666716"])
    end
  end

  describe "#alchemy_targeted_sentiment" do
    it "returns the sentiment value for a specific keyword" do
      expect(alchemy_targeted_sentiment("I hate my dog.", "dog")).to eql("-0.888208")
    end
  end
end