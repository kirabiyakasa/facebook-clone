class PostsController < ApplicationController
  before_action :allow_posting, only: [:index, :create]
  before_action :set_preview_comments_count, only: [:index]

  def index
    user_ids = current_user.friends.pluck(:id) << current_user.id
    @pagy, 
    @posts = pagy(Post.where(user_id: user_ids)
                      .order('created_at DESC')
                      .includes(:likes, :dislikes, :user, :comments, :replies,
                               # nested comments associations
                               {comments: [:user, :likes, :dislikes, :replies]}),
                  items: 5)
    respond_to do |format|
      format.html
      format.json {
        render json: {
          entries: render_to_string(partial: 'posts_list', formats: [:html]),
          postsPagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end

  def create
    @post = Post.create(user_id: current_user.id, body: params[:body])

    respond_to do |format|
      if @post.save
        format.html { redirect_back fallback_location: root_path,
        notice: 'Post was successfully created.' }
        format.json { render :back, status: :created, location: @post }
      else
        format.html { redirect_back fallback_location: root_path }
        format.json { render json: @post.errors,
        status: :unprocessable_entity }
      end
    end
  end

  def comment
    @post = Post.find(params[:id])
    head(403) unless @post.user_id == current_user.id

    user_id = @post.user_id
    body = params[:body]

    @post.comments.build(user_id: user_id, body: body)
    @post.save
  end

  private

  def new_post_notification
  end

end
