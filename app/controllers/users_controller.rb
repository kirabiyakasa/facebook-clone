class UsersController < ApplicationController
  before_action :allow_posting, only: [:show]
  before_action :set_preview_comments_count, only: [:show]

  def show
    @user = User.find(params[:id])
    @pagy, 
    @posts = pagy(@user.posts
                       .order('created_at DESC')
                       .includes(:likes, :dislikes, :comments, :replies,
                                # nested comments associations
                                {comments: [:user, :likes, :dislikes, :replies,
                                 :recent_replies,
                                # nested replies associations
                                {recent_replies: [:user, :likes, :dislikes]}]}),
                  items: 5)
  end

end
