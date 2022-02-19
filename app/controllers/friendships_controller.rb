class FriendshipsController < ApplicationController
  before_action :valid_friend_request?, only: [:create]

  def create
    current_user.friendships.build(friend_id: @friend.id).save
  end

  private

  def valid_friend_request?
    @friend = User.find(params[:friend_id])
    if helpers.user_is_self?(@friend.id) || current_user.friend?(@friend)
      head(403)
    end
  end

end
