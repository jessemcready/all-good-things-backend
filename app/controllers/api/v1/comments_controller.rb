class Api::V1::CommentsController < ApplicationController

  def index
    render json: @comments, each_serializer: CommentSerializer, status: :ok
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment, status: :ok
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end

end
