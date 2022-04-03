module PostsHelper

  def preview_comment(comments)
    [comments.last]
  end

  def get_unloaded_comments_count(post)
    post.comments.length - @preview_comments_count
  end

end
