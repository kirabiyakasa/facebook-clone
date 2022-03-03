class UsersController < ApplicationController
  before_action :allow_posting, only: [:show]

  def show
    @user = User.find(params[:id])
    @pagy, 
    @posts = pagy(@user.posts.order('created_at DESC')
                       .includes(:likes, :dislikes, :comments, :replies,
                                # nested comments associations
                                {comments: [:user, :likes, :dislikes, :replies,
                                # nested replies associations
                                {replies: [:user, :likes, :dislikes]}]}
                  ), items: 10)
  end

end
