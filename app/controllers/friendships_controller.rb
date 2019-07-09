# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    new_friend = User.find_by(github_uid: friendship_params[:uid])
    friendship = Friendship.new(user: current_user, friend: new_friend)
    if friendship.save
      flash[:notice] = "Congrats, you are now friends with #{new_friend.first_name + ' ' + new_friend.last_name}!"
    else
      flash[:danger] = 'Oops! Something went wrong!'
    end
    redirect_to dashboard_path
  end

  private

  def friendship_params
    params.permit(:uid)
  end
end
