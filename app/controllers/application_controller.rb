class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :user_still_signed_in?
  before_action :get_notifications

  def user_still_signed_in?
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
      end
    end
  end

  def create_notification(u_id, type, n_id)
    n = Notification.create(user_id: u_id, notifiable_type: type, 
                                           notifiable_id: n_id)
  end

  def get_notifications
    @pagy_n, @notifications = pagy current_user.notifications
  end
end
