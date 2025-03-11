class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    current_user.friendships.create(friend: friend)
    redirect_to root_path, notice: "Friend request sent."
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "User not found."
  end

  def index
    @pending_friend_requests = current_user.pending_friend_requests
    @friends = current_user.friends
    render :index
  end

  def update
    friendship = Friendship.find(params[:id])

    if friendship.friend == current_user && friendship.status == 'pending'
      friendship.accept_friend_request
      flash[:notice] = "Friend request accepted."
    else
      flash[:alert] = "You can't accept this friend request."
    end

    redirect_to friendships_path
  end

  def destroy
    friendship = Friendship.find(params[:id])

    if friendship.friend == current_user || friendship.user == current_user
      friendship.destroy
      flash[:notice] = "Friendship deleted."
    else
      flash[:alert] = "You can't delete this friendship."
    end

    redirect_to friendships_path
  end

  def pending
    @pending_requests = current_user.pending_friend_requests
  end

  def accept
    set_friendship
    if @friendship
      @friendship.update(status: 'accepted')
      redirect_to user_friendships_path(current_user), notice: 'Friend request accepted.'
    else
      redirect_to user_friendships_path(current_user), alert: 'Friend request not found.'
    end
  end

  def reject
    @friendship.destroy
    redirect_to user_friendships_path(current_user), notice: 'Friend request rejected.'
  end

  private

  def set_friendship
    @friendship = Friendship.find_by(id: params[:id], friend_id: current_user.id)
  end
end
