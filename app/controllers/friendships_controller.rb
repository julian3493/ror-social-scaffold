class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friendships.all
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:id], status: false)
    if @friendship.save
      redirect_to users_path, notice: 'You have sent a friendship request!'
    else
      redirect_to users_path, alert: 'Friendship request Sent already!'
    end
  end

  def destroy
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    if @friendship
      @friendship.destroy
      @inverse = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
      @inverse.destroy if @inverse
      redirect_to users_path, notice: 'Friend has been removed'
    else
      redirect_to root_path, alert: 'You are not allowed to do this'
    end
  end
end
