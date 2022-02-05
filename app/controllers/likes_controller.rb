class LikesController < ApplicationController
  before_action :set_tweet, only: [:create]
  def new
    @like = Like.new
  end

  def create
    if already_liked?
      Like.find_by(user_id: current_user.id).destroy
      # flash[:notice] = "You can't like more than once"
    else
      @tweet.likes.create(user: current_user)
    end
    redirect_back_or_to root_path
  end

  def already_liked?
    Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
