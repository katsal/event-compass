class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    # Condition to make sure to select events that has come to an end by today.
    @events = Event.all.where("end_date >= ?", Event.date_today)
    @events = @events.where.not(user: current_user) if current_user&.admin?
    @events = policy_scope(@events)


    if params[:q].present?
      @events = @events.global_search(params[:q])
    end

    if params[:opening_date].present?
      date_range = params[:opening_date].split(' to ')
      if date_range.length == 1
        selected_date = Date.parse(date_range[0]).to_datetime
        @events = @events.for_a_day(selected_date)
      elsif date_range.length == 2
        start_date = Date.parse(date_range[0]).to_datetime
        end_date = (Date.parse(date_range[1]) + 1).to_datetime
        @events = @events.starts_within_range(start_date, end_date)
      end
    end
    if params[:category].present?
      @events = @events.joins(:category).where(category: { name: params[:category] })
    end


    if params[:order] == "date"
      @events = @events.order(:start_date)
    elsif params[:order] == "popularity"
      @events = @events
        .joins("LEFT JOIN event_lists ON event_lists.event_id = events.id")
        .group("events.id")
        .order("COUNT(event_lists.id) DESC")
    end

    @markers = get_markers(@events)


  end

  def show
    @event = Event.find(params[:id])
    authorize @event
    @user_comments = Comment.all.where(event_id: @event).order(created_at: :desc)
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

  private

  def get_markers(events)
    events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        popup_html: render_to_string(partial: "shared/map_popup", locals: { event: event }),
        marker_html: render_to_string(partial: "shared/map_marker", locals: { event: event })
      }
    end
  end

end
