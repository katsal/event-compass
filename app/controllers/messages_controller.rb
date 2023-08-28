class MessagesController < ApplicationController
  def index
    @messages = current_user.messages(@recipient)
  end

  def create

  end
end
