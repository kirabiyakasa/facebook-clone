class CommentsController < ApplicationController

  def section
    @comment_count = params[:comment_count].to_i
    @post_id = params[:post_id]
    @pagy, 
    @comments = pagy(Comment.where(post_id: @post_id, comment_id: nil)
                            .includes(:likes, :dislikes, :user, :replies,
                                      # nested replies associations
                                      {replies: [:user, :likes, :dislikes]}
                    ), items: 15)
  end

  def create
    @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id],
                           body: params[:body])
    if params[:comment_id]
      @comment.comment_id = params[:comment_id]
      @appending_reply = true
    else
      @appending_comment = true
    end

    if @comment.save
      @comments = [@comment]
    else
      head(404)
    end
  end

  private

  def comment_params
    if params[:comments]
      params.require(:comments).permit(:comment_id, :body)
    else
      false
    end
  end

end
