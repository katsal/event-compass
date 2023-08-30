class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @follower_count = @user.favoritors.count
    @following_count = @user.favorites.count

    authorize @user
    user_lists = current_user.lists
    @past_events = Event.joins(event_lists: :list)
                        .where('lists.id IN (?) AND events.start_date < ?', user_lists.pluck(:id), Date.today)
                        .order(start_date: :desc)
                        .distinct
    @upcoming_events = Event.joins(event_lists: :list)
                            .where('lists.id IN (?) AND events.start_date >= ?', user_lists.pluck(:id), Date.today)
                            .order(start_date: :desc)
                            .distinct
    @comment = Comment.new
    @user_comments = Comment.all.where(user_id: @user).order(created_at: :desc)

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

  def update
    @user = User.find(params[:id])
    authorize @user
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:my_photo)
  end

end
