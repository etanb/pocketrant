class UsersController < ApplicationController
  include SentimentHelper
  before_filter :authenticate_user!, :except => [:index]
  prepend_before_filter :require_no_authentication, :only => [:create]

  def show
    @messages = Message.all
    binding.pry
  end



end

