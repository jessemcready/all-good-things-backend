class Api::V1::LikesController < ApplicationController

  def index
    render json: @likes, each_serializer: LikeSerializer, status: :ok
  end

  def create
    @like = Like.new(like_params)
    if @like.save
      render json: @like, status: :created
    else
      render json: { errors: @like.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @like = Like.find_by(like_params)
    @like.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end

end
