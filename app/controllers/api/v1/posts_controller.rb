class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all.map do |post|
      PostSerializer.new(post)
    end
    render json: @posts, status: :ok
  end

  def show
    @post = Post.find(params[:id])
    render json: PostSerializer.new(@post), status: :ok
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: PostSerializer.new(@post), status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content)
  end

end
