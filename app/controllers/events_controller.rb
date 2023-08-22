class EventsController < ApplicationController

  def index
    if params[:q].present?
      @events = Event.global_search(params[:q])
    else
      @events = Event.all
    end
  end

end
