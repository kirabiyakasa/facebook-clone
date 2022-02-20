module NotificationsHelper

  def notification_content(n)
    case n.notifiable_type
    when 'Friendship'
      return friendship_notification(n)
    end
  end

  def friendship_notification(n)
    m = "#{n.notifiable.user.name} sent you a friend request."
    url = friendships_path
    return {:url => url, :message => m}
  end

end
