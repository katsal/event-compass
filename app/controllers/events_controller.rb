class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @events = policy_scope(Event.all)
    if params[:q].present?
      @events = @events.global_search(params[:q])
    end
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end

end
