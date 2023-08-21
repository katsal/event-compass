class EventsController < ApplicationController
  # skip_before_action :authorize, only: :index
  skip_after_action :verify_authorized, only: [ :show, :index ]

  def index
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
    # @list = Booking.new
  end

end
