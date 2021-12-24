class UsersController < ApplicationController

  def show
    if params[:id]
      @user = User.find params[:id]
    else
      unless @user = current_user
        respond_to do |format|
          format.html { redirect_to new_user_session_path }
        end
      end
    end
  end

end
