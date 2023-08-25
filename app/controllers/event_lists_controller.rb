class EventListsController < ApplicationController

  def create
    @event_list = EventList.new(event_list_params)
    authorize @event_list
    if @event_list.save
      flash[:notice] = "Event saved to list"
      redirect_to event_path(@event_list.event)
    else
      redirect_to event_path(@event_list.event)
    end
  end

  private

  def event_list_params
    params.permit(:list_id, :event_id)
  end


end
