class MessagesController < ApplicationController
  before_action :set_recipient

  def index
    # @messages = policy_scope(@messages)
    @messages = policy_scope(Message)
    @messages = current_user.messages(@recipient)
  end

  def create
    @message = Message.new(sender: current_user, recipient: @recipient, content: params[:content])
    authorize @message
    if @message.save
      MessagesChannel.broadcast_to(
        current_user,
        render_to_string(partial: "messages/message", locals: {message: @message, user: current_user})
      )
      MessagesChannel.broadcast_to(
        @recipient,
        render_to_string(partial: "messages/message", locals: {message: @message, user: @recipient})
      )
      head :ok
    else

      render "messages", status: :unprocessable_entity
    end
  end

  private

  def set_recipient
    @recipient = User.find(params[:user_id])
  end

end
