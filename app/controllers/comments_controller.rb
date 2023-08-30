class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    authorize @comment
    if @comment.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    authorize @comment

    vote_type = comment_params[:vote_type]

    if current_user.voted_for?(@comment)
      @comment.unliked_by current_user
    else
      @comment.liked_by current_user
    end

    # Determine the redirection URL based on the context
    redirect_url = if request.referer&.include?(user_path(current_user))
                     user_path(current_user)
                   elsif request.referer&.include?(event_path(@comment.event))
                     event_path(@comment.event)
                   else
                     root_path
                   end

    respond_to do |format|
      format.html { redirect_to redirect_url }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    # raise
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment deleted"
      redirect_to event_path(@comment.event_id)
    else
      flash[:notice] = "Error in deleting the comment"
      redirect_to root
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :event_id, :comment, :body, photos: [])
  end

end
