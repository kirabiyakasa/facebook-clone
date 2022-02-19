module UsersHelper

  def user_is_self?(friend_id)
    current_user.id == friend_id
  end

end
