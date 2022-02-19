class FriendshipsController < ApplicationController
  before_action :valid_friend_request?, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @friendships = @user.friendships.preload(:friend)
    @inverse_friendships = @user.inverse_friendships.preload(:user)

    @friend_requests = @user.friend_requests
    @pending_friends = @user.pending_friends
    @friends = @user.friends
  end

  def create
    current_user.friendships.build(friend_id: @friend.id).save
  end

  def accept
    @friendship = Friendship.find(params[:id])
    if @friendship.friend_id == current_user.id 
      @friendship.update(confirmed: true)
    else
      head(403)
    end
  end

  def cancel
    @friendship = Friendship.find(params[:id])
    head(403) if @friendship.confirmed
    if @friendship.user_id == current_user.id 
      @friendship.destroy
    end
  end

  def remove
    @friendship = Friendship.find(params[:id])
    head(403) unless @friendship.confirmed
    if [@friendship.user_id, @friendship.friend_id].include?(current_user.id) 
      @friendship.destroy
    end
  end

  private

  def valid_friend_request?
    @friend = User.find(params[:friend_id])
    if helpers.user_is_self?(@friend.id) || current_user.friend?(@friend)
      head(403)
    end
  end

end
