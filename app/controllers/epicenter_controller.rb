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
    @user = current_user
    @tweets = Tweet.where(user_id: current_user.following.push(current_user.id)).order(created_at: :desc)
    set_followers
    # <!-- .joins joins the 3 tables -->
    @trending_phrases = Tweet.where('tweets.created_at > ?', 3.days.ago).joins(:tags).group(:phrase).count
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

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def all_users
    @users = User.all
    # or:
    # User.order(:username)
    # User.order(:name)
    # or whatever order you'd
    # like to put them in
  end

# the following gives the total number of followers
  def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
  end

  def followers
    @user = User.find(params[:id])
    set_followers
    @users = @followers
  end

# when you call a method set_ the point is to set an instance variable
  def set_followers
    @followers = []
    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end

end
