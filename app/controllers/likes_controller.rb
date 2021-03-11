class LikesController < ApplicationController
  before_action :set_like, only: [:show, :update, :destroy]

  # GET /likes
  def index
    @likes = Like.all

    render json: @likes
  end

  def popular
    popular_posts = Like.group(:postId).order(count_all: :desc).count.map { |k, v| [{k => v}] }.map{|x|x.first}

    render json: popular_posts
  end

  def fan
    biggest_fans = Like.group(:user).order(count_all: :desc).count.map { |k, v| [{k => v}] }.map{|x|x.first}

    render json: biggest_fans
  end

  def week
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
