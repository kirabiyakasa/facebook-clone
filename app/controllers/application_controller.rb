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
    @pagy_n,
    @notifications = pagy(current_user.notifications
                                      .includes(:notifiable), 
                          items: 10, page_param: :n_page)
    preload_notifiable_user
  end

  def allow_posting
    if params[:id]
      if params[:id] == current_user.id
        @can_post = true
      end
    else
      @can_post = true
    end
  end

  def set_preview_comments_count
    @preview_comments_count = 1
  end

  private

  def preload_notifiable_user
    preloader = ActiveRecord::Associations::Preloader.new
    preloader.preload(
      @notifications.select { |p| p.notifiable_type == 'Friendship' },
      notifiable: [:user]
    )
  end

end
