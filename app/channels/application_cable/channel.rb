module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      stream_for "messages_#{params[:user_id]}"
    end
  end
end
