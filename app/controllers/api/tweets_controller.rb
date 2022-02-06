module Api
  class TweetsController < ApiController
    before_action :set_tweet, only: %i[show update destroy ]

    # GET /tweets
    def index
      render json: Tweet.all, status: :ok
    end

    # GET /tweets/1
    def show
      render json: @tweet, status: :ok
    end

    # POST /tweets
    # POST /users/:user_id/tweets
    def create
      @tweet = Tweet.create(body: tweet_params[:body], user_id: params[:user_id])
      @tweet.replied_to_id = params[:tweet_id] unless params[:tweet_id].nil?

      if @tweet.save
        render json: @tweet, status: :created
      else
        render json: {errors: @tweet.errors}, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tweets/1
    def update
      if @tweet.update(tweet_params)
        render json: @tweet, status: :ok
      else
        render json: {errors: @tweet.errors}, status: :unprocessable_entity
      end
    end

    # DELETE /tweets/1
    def destroy
      @tweet.destroy
      head :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:body, :user_id)
    end
  end
end