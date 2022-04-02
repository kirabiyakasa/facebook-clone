module CommentsHelper

  def get_offset
    if @old_comment_count
      @new_comment_count - @old_comment_count
    else
      0
    end
  end

  def reply_count_message(replies, i)
    if replies.length > 1
      "#{replies.length} Replies"
    elsif replies.length == 1
      "1 Reply"
    end
  end

  def comment_options
    options = 
    '<ul class="comment-options">' +
      '<li class="comment-option">' +
        '<span class="like-comment">Like</span>' +
      '</li>' +
      '<li class="comment-option">' +
        '<span class="dislike-comment">Dislike</span>' +
      '</li>' +
      '<li class="comment-option">' +
        '<span class="reply-to-comment" ' +
        'data-action="click->comments#reply">Reply</span>' +
      '</li>' +
    '</ul>'
    options.html_safe
  end

  def merge_comments(comment)
    merged_comments = [comment] + comment.replies
    return merged_comments
  end

  def get_replies_container
    if @posts
      ('<div class="replies-container" style="display:none">').html_safe
    else
      ('<div class="replies-container">').html_safe
    end
  end

  def parent_comment_id(comment)
    if comment.comment_id
      comment_id = comment.comment_id
    else
      comment_id = comment.id
    end
  end

end
