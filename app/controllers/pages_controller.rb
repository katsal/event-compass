class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @events = Event.all

    @top_events = Event.joins(:event_lists).group('events.id')
    .order('COUNT(event_lists.id) DESC').limit(6)
  end
end
