class PostsController < ApplicationController
  before_action :allow_posting, only: [:index, :create]

  def index
    user_ids = current_user.friends.map {|friend| friend.id} << current_user.id
    @pagy, 
    @posts = pagy(Post.where(user_id: user_ids)
                      .order('created_at DESC')
                      .includes(:likes, :dislikes, :user, :comments, :replies,
                               # nested comments associations
                               {comments: [:user, :likes, :dislikes, :replies,
                               # nested replies associations
                               {replies: [:user, :likes, :dislikes]}]}
                  ), items: 15) # simplify
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
