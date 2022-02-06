module Api
  class LikesController < ApiController
    before_action :set_like, only: %i[destroy]

    # POST /tweets
    # POST /users/:user_id/tweets
    def create
      @like = Like.new(like_params)
      if @like.save
        render json: @like, status: :created
      else
        render json: { errors: @like.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /tweets/1
    def destroy
      Like.find(params[:id]).destroy
      head :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:id, :user_id, :tweet_id)
    end
  end
end
