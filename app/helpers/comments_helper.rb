module CommentsHelper

  def get_offset
    @posts ? 0 : 1
  end

  def reply_count_message(replies, i)
    if replies.length > 1
      "#{@comments[i].replies.length} Replies"
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
        '<span class="reply-to-comment">Reply</span>' +
      '</li>' +
    '</ul>'
    options.html_safe
  end

end
