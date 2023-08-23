class EventsController < ApplicationController
  def index
    @event = Event.new
    @events = policy_scope(Event)
    @events = Event.all

    if params[:q].present?
      @events = Event.global_search(params[:q])
    else
      @events = Event.all
    end

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude
    #     popup_html: render_to_string(partial: "shared/map_popup", locals: { event: event }),
    #     marker_html: render_to_string(partial: "shared/map_marker", locals: { event: event })
      }
    end
  end
end
