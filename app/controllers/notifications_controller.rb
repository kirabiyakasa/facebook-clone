class NotificationsController < ApplicationController
  skip_before_action :get_notifications, only: [:index]

  def index
    @pagy_n, @notifications = pagy current_user.notifications
                                               .includes(:notifiable)

    preload_notifiable_user
  end

end
