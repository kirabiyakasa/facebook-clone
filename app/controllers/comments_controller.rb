class CommentsController < ApplicationController
  before_action :set_preview_comments_count, only: [:section]

  def section
    old_comment_count = params[:comment_count].to_i
    @post_id = params[:post_id]
    new_comment_count = Comment.where(post_id: @post_id,
                                       comment_id: nil).length
    pagy_items = 15
    starting_item_outset = new_comment_count - old_comment_count
    @pagy_c,
    @comments = pagy(Comment.where(post_id: @post_id, comment_id: nil)
                            .order('created_at DESC')
                            .includes(:likes, :dislikes, :user,
                                      :recent_replies,
                                      # nested replies associations
                                      {recent_replies: [:user,
                                                        :likes,
                                                        :dislikes]})
                            .offset(starting_item_outset),
                    items: pagy_items, outset: starting_item_outset)
    respond_to do |format|
      format.js
      @pagy_c.page == @pagy_c.last ? last_page = true : last_page = false
      format.json {
        render json: {
          comments: render_to_string(partial: 'section', formats: [:html]),
          commentsPagination: view_context.pagy_nav(@pagy_c)
        }
      }
    end
  end

  def more_replies
    @replies = true
    @comment = Comment.find(params[:id])
    @initial_reply_count = params[:initial_reply_count].to_i
    @current_reply_count = @comment.replies.length
    @page = params[:page].to_i
    replies_per_page = @comment.replies_per_page

    extra_replies_count = helpers.get_extra_replies_count(@comment)
    new_reply_count = @current_reply_count - @initial_reply_count

    offset = @page * replies_per_page

    if extra_replies_count >= replies_per_page
      limit = replies_per_page
    else
      limit = extra_replies_count
    end

    @page += 1

    @replies = @comment.get_next_replies(@comment, offset, limit)

    respond_to do |format|
      loaded_replies_count = offset
      format.json {
        render json: {
          replies: render_to_string(partial: 'section', formats: [:html]),
          loadedRepliesCount: loaded_replies_count,
          newRepliesCount: limit,
          repliesPerPage: replies_per_page,
          button: render_to_string(partial: 'more_replies', formats: [:html])
        }
      }
    end
  end

  def create
    @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id],
                           body: params[:body])
    if params[:comment_id]
      @comment.comment_id = params[:comment_id]
      @appending_single_reply = true
    else
      @appending_single_comment = true
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
