class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    user_lists = current_user.lists
    @past_events = Event.joins(event_lists: :list)
                        .where('lists.id IN (?) AND events.start_date < ?', user_lists.pluck(:id), Date.today)
                        .order(start_date: :desc)
                        .distinct
    @comment = Comment.new
    @user_comments = Comment.all.where(user_id: @user).order(created_at: :desc)
  end
end
