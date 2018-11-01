class Api::V1::LikesController < ApplicationController

  def index
    @likes = Like.all.map do |like|
      LikeSerializer.new(like)
    end
    render json: @likes, status: :ok
  end

  def create
    @like = Like.new(like_params)
    if @like.save
      render json: LikeSerializer.new(@like), status: :created
    else
      render json: { errors: @like.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end

end
