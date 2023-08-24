class ListsController < ApplicationController
  def show
    @list = List.find(params[:id])
    authorize @list
  end
end
