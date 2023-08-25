class ListsController < ApplicationController

  def show
    @list = List.find(params[:id])
    authorize @list
  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    # binding.pry
    authorize @list
    if @list.save
      # redirect_to list_path(@list.id)
      redirect_to events_path
    else
      raise
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :location, :start_date, :end_date)
  end
end
