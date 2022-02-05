class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy ]

  # GET /tweets
  def index
    @tweets = Tweet.all.select { |tweet| tweet.replied_to_id.nil? }.sort_by(&:created_at).reverse!
    @tweet_new = Tweet.new
    @tweets_of_current_user = Like.where(user_id: current_user.id).map(&:tweet) if current_user
  end

  # GET /tweets/1
  def show
    @tweet_new = Tweet.new
    @retweets = @tweet.retweets.sort_by(&:created_at).reverse!
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit; end

  # POST /tweets
  # POST /users/:user_id/tweets
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.replied_to_id = params[:tweet_id] unless params[:tweet_id].nil?

    if @tweet.save
      redirect_back_or_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      redirect_to root_path, notice: "Tweet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
    redirect_back_or_to root_path, notice: "Tweet was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
