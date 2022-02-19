class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy @user.posts.includes(:likes, :dislikes)
  end

end
