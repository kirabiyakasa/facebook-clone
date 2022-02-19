class PostsController < ApplicationController

  def index
    user_ids = current_user.friends.map {|friend| friend.id} << current_user.id
    @pagy, @posts = pagy Post.where(user_id: user_ids).order('created_at DESC')
                             .includes(:likes, :dislikes, :user)
  end

end
