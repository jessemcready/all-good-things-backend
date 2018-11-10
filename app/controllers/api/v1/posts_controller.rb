class Api::V1::PostsController < ApplicationController
  before_action :authorized, only: [:flagged]

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
      render json: { post: PostSerializer.new(@post) }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  def report
    @post = Post.find(params[:id])
    @post.update(flagged: true)
    render json: { post: PostSerializer.new(@post) }, status: :created
  end

  def unreport
    @post = Post.find(params[:id])
    @post.update(flagged: false)
    render json: { post: PostSerializer.new(@post) }, status: :created
  end

  def flagged
    if current_user.admin
      @posts = Post.where(flagged: true).map do |post|
        PostSerializer.new(post)
      end
      render json: @posts, status: :ok
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content)
  end

end
