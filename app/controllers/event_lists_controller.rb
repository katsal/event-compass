class EventListsController < ApplicationController

  def create
    @event_list = EventList.new(event_list_params)
    authorize @event_list
    if EventList.exists?(event_id: @event_list.event_id, list_id: @event_list.list_id)
      flash[:alert] = "Event is already in the list"
      redirect_to event_path(@event_list.event)
    elsif @event_list.save
      flash[:notice] = "Event saved to list"
      redirect_to list_path(@event_list.list)
    else
      redirect_to event_path(@event_list.event)
      flash[:notice] = "Event unable to be saved"
    end
  end

  def destroy
    @event_list = EventList.find_by(list_id: params[:id],event_id: params[:event_id])
    authorize @event_list
    if @event_list.destroy
      redirect_to list_path(@event_list.list)
    else
      render 'lists/show', status: :unprocessable_entity
    end
  end

  private

  def event_list_params
    params.permit(:list_id, :event_id)
  end


end
