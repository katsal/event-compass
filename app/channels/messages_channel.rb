class MessagesChannel < ApplicationCable::Channel
  def subscribed
  # stream_from "some_channel"
  stream_for User.find(params[:id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
