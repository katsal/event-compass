class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @events = Event.all
    @events = @events.where.not(user: current_user) if current_user&.admin?
    @events = policy_scope(@events)


    if params[:q].present?
      @events = @events.global_search(params[:q])
    end

    if params[:opening_date].present?
      date_range = params[:opening_date].split(' - ')
      if date_range.length == 1
        selected_date = Date.parse(date_range[0])
        @events = @events.where("start_date <= ? AND (end_date >= ? OR end_date IS NULL)", selected_date, selected_date)
      elsif date_range.length == 2
        start_date = Date.parse(date_range[0])
        end_date = Date.parse(date_range[1])
        @events = @events.starts_within_range(start_date, end_date)
      end
    end

    if params[:category].present?
      @events = @events.joins(:category).where(category: { name: params[:category] })
    end

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        popup_html: render_to_string(partial: "shared/map_popup", locals: { event: event }),
        marker_html: render_to_string(partial: "shared/map_marker", locals: { event: event })
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    authorize @event

    @markers = [@event].compact.map do |event|  # Use @event instead of @events
      {
        lat: event.latitude,
        lng: event.longitude,
        popup_html: render_to_string(partial: "shared/map_popup", locals: { event: event }),
        marker_html: render_to_string(partial: "shared/map_marker", locals: { event: event })
      }
    end
  end


  def ical_calendar_url(event)
    start_date = event.date.strftime('%Y%m%dT%H%M%S') + 'Z'
    end_date = (event.date + event.duration.hours).strftime('%Y%m%dT%H%M%S') + 'Z'

    # Build the iCal Calendar URL with formatted start and end dates
    # Example: "data:text/calendar;charset=utf8,BEGIN:VCALENDAR\nVERSION:2.0\nBEGIN:VEVENT\nDTSTART:20291231T210000Z\nDTEND:20300101T205900Z\n..."
  end

end
