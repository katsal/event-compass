class MessagesController < ApplicationController

  def index
    # @messages = policy_scope(@messages)
    @messages = policy_scope(Message)
    @recipient = User.find(params[:user_id])
    @messages = current_user.messages(@recipient)
  end

  def create
    # content
    # sender
    # recipient
  end
end
