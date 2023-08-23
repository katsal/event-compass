class EventsController < ApplicationController
  def index
    @events = policy_scope(Event)

    if params[:q].present?
      @events = Event.global_search(params[:q])
    else
      @events = Event.all
    end
  end
end
