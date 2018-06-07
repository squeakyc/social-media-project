class EpicenterController < ApplicationController
  # def feed
  #   @tweets = []
  #
  #   Tweet.all.each do |tweet|
  #     if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
  #       @following_tweets.push(tweet)
  #     end
  #   end
  # end
before_action :authenticate_user!
# The following is the same as above, but less code & puts more of the responsibility on the database, which is what it's build for!
  def feed
    @tweets = Tweet.where(user_id: current_user.following.push(current_user.id))
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    current_user.following.push(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end
end
