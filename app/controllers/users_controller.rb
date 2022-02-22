class UsersController < ApplicationController
  before_action :allow_posting, only: [:show]

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy @user.posts.order('created_at DESC')
                              .includes(:likes, :dislikes)
  end

end
