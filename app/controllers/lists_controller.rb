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
      if params[:return_to].present?
        puts "Return to: #{params[:return_to]}"
        redirect_to URI.decode_www_form_component(params[:return_to])
      else
        redirect_to events_path
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @user = @list.user
    authorize @list
    if @list.destroy
      redirect_to user_path(@user)
    else
      render 'users/show', status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :location, :start_date, :end_date)
  end
end
