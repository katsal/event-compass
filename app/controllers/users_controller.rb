class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @follower_count = @user.favoritors.count
    @following_count = @user.favorites.count

    authorize @user
    user_lists = current_user.lists
    @past_events = Event.joins(event_lists: :list)
                       .where('lists.id IN (?) AND events.start_date <= ?', user_lists.pluck(:id), Date.today)
                       .order(start_date: :desc)
                       .distinct
    @comment = Comment.new

  end

  def follow
    puts "following"
    @user = User.find(params[:id])
    authorize @user
    current_user.favorite(@user)
    redirect_to @user, notice: 'You are now following this user.'
  end

  def unfollow
    @user = User.find(params[:id])
    authorize @user
    current_user.unfavorite(@user)

    redirect_to @user, notice: 'You have unfollowed this user.'
  end
end
