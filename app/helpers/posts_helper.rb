module PostsHelper

  def preview_comment(comments)
    [comments.order(created_at: :asc)
             .includes(:likes, :dislikes, :user, :replies)
             .last]
  end

  def at_user
  end

end
