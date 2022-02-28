class CommentsController < ApplicationController

  def section
    @post_id = params[:post_id]
    @pagy, 
    @comments = pagy(Comment.where(post_id: @post_id, comment_id: nil)
                            .order('created_at ASC')
                            .includes(:likes, :dislikes, :user, :replies,
                                      # nested replies associations
                                      {replies: [:user, :likes, :dislikes]}
                    ), items: 15)
  end

end
