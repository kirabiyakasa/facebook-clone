class PostsController < ApplicationController

  def index
    @user = current_user
    user_ids = @user.friends.map {|friend| friend.id} << @user.id
    @pagy, @posts = pagy Post.where(user_id: user_ids).order('created_at DESC')
                             .includes(:likes, :dislikes, :user)
  end
  # condition to only show the user's posts instead of complete timeline

end
