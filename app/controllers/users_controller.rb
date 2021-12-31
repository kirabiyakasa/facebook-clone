class UsersController < ApplicationController

  def show
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
      end
    end

    if params[:id]
      @user = User.find params[:id]
    else
      @user = current_user
    end
  end

end
