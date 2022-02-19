module FriendshipsHelper

  def get_friendship_id(friend_id)
    if friendship_id = @friendships.detect {|f| f.friend_id == friend_id }
      return friendship_id
    else
      @inverse_friendships.detect {|f| f.user_id == friend_id }
    end
  end

end
