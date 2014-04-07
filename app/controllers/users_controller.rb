class UsersController < ApplicationController
  include SentimentHelper
  before_filter :authenticate_user!, :except => [:index]
  prepend_before_filter :require_no_authentication, :only => [:create]

  def show

    gon.messages = Message.all
    all_messages = gon.messages.map {|data| data.text}
    gon.keywords = alchemy_ranked_keywords(all_messages.join(" "))

  end



end

