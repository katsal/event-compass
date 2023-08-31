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

    current_following = current_user.favorited_users
    current_following_lists = current_following.map { |user| user.lists}.flatten
    current_following_event_lists =  current_following_lists.map { |list| list.event_lists}.flatten

    following_users_comments = current_user.favorited_users.map { |user| user.comments}.flatten
    my_events_comments = current_user.lists.map { |list| list.events.map {|event| event.comments}}.flatten

    @comments_and_event_lists_ordered = following_users_comments + my_events_comments + current_following_event_lists
    @comments_and_event_lists_ordered = @comments_and_event_lists_ordered.sort_by{ |comment| comment.created_at}
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
    @user.status = params[:user][:status] if params[:user][:status]
    authorize @user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Details updated succesfully.'
    else
      render 'users/show', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:my_photo, :status)
  end

end
