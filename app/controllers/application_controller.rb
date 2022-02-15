class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :user_still_signed_in?

  def user_still_signed_in?
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
      end
    end
  end
end
