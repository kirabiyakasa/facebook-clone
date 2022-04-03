module CommentsHelper

  def reply_count_message(replies, i)
    if replies.length > 1
      "#{replies.length} Replies"
    elsif replies.length == 1
      "1 Reply"
    end
  end

  def comment_options
    options = ['like', 'dislike']

    comment_options = options.collect {
      |action| content_tag(:li, content_tag(
        :span, action, class: action + '-comment'
        ), class: 'comment-option'
      )
    }

    reply_button = content_tag(:li, content_tag(
      :span, 'Reply', class: 'replt-to-comment',
      data: { action: 'click->comments#reply' }
      ), class: 'comment-option'
    )

    content_tag :ul, class: 'comment-options' do
      (comment_options << reply_button).join.html_safe
    end
  end

  def merge_comments(comment)
    merged_comments = [comment] + comment.recent_replies
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

  def next_comments_count(pagy)
    if pagy.page + 1 == pagy.last
      return pagy.count - (pagy.page * pagy.items)
    else
      return pagy.items
    end
  end

  def replies_to_load?(comment)
    extra_replies_count = get_extra_replies_count(comment)

    if extra_replies_count > 0
      return true
    else
      return false
    end
  end

  def more_replies_container(comment)
    button =
      content_tag(:div,
                  (more_replies_button(comment) +
                   more_replies_anchor(comment)),
                  data: {action: 'click->comments#showMoreReplies'},
                  class: 'show-more-replies')
    return button.html_safe
  end

  def more_replies_button(comment)
    extra_replies_count = get_extra_replies_count(comment)
    content = "Load #{extra_replies_count} more "
    extra_replies_count > 1 ? content += 'replies' : content +='reply' 

    button = content_tag(:span, content)
    return button.html_safe
  end

  def more_replies_anchor(comment)
    @page ||= 1
    @initial_reply_count ||= comment.replies.length

    anchor =
      content_tag(
        :a,
        '',
        href: more_replies_comment_path(id: comment.id, page: @page,
                                  initial_reply_count: @initial_reply_count),
        data: {comments_target: 'repliesPagination'},
        style: 'display:none')
    return anchor.html_safe
  end

  def get_extra_replies_count(comment)
    unless @replies
      initial_reply_count = comment.replies.length
      loaded_replies_count = comment.replies_per_page
    else
      initial_reply_count = @initial_reply_count
      loaded_replies_count = @page * comment.replies_per_page
    end
    return initial_reply_count - loaded_replies_count
  end

end
