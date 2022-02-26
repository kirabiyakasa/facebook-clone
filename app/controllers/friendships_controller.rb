class FriendshipsController < ApplicationController
  before_action :valid_friend_request?, only: [:create]
  after_action :new_friend_notification, only: [:create]
  after_action :delete_friend_notification, only: [:accept]


  def index
    @user = current_user
    @friendships = @user.friendships.preload(:friend)
    @inverse_friendships = @user.inverse_friendships.preload(:user)

    @friend_requests = @user.friend_requests
    @pending_friends = @user.pending_friends
    @friends = @user.friends
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friendship.save
  end

  def accept
    @friendship = Friendship.find(params[:id])

    head(403) if recevied_request? == false || @friendship.confirmed
    @friendship.update(confirmed: true)
  end

  def cancel
    @friendship = Friendship.find(params[:id])

    head(403) if sent_request? == false || @friendship.confirmed
    @friendship.destroy
  end

  def remove
    @friendship = Friendship.find(params[:id])

    head(403) unless @friendship.confirmed
    if in_friendship?
      @friendship.destroy
    end
  end

  private

  def valid_friend_request?
    if current_user.user_is_self?(params[:friend_id]) ||
       current_user.friendship_already_exists?(params[:friend_id])
      head(403)
    end
  end

  def recevied_request?
    @friendship.friend_id == current_user.id
  end

  def sent_request?
    @friendship.user_id == current_user.id
  end

  def in_friendship?
    [@friendship.user_id, @friendship.friend_id].include?(current_user.id)
  end

  def new_friend_notification
    friend_id = @friendship.friend_id
    type = 'Friendship'
    notifiable_id = @friendship.id
    create_notification(friend_id, type, notifiable_id)
  end

  def delete_friend_notification
    @friendship.notification.destroy
  end

end
