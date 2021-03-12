class LikesController < ApplicationController
  before_action :set_like, only: [:show, :update, :destroy]

  # GET /likes
  def index
    @likes = Like.all

    render json: @likes
  end

  def popular_posts
    render json: Like.popular_posts
  end

  def biggest_fans
    render json: Like.biggest_fans
  end

  def popular_days
  end

  # GET /likes/1
  def show
    render json: @like
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:postId, :user, :date)
    end
end
