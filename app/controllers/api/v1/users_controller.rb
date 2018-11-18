class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    @users = User.order(created_at: :desc)
    render json: @users, each_serializer: UserSerializer, status: :ok
  end

  def show
    if params[:id] != 'current'
      @user = User.find(params[:id])
      render json: { user: UserSerializer.new(@user) }, status: :accepted
    else
      render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: @token },
      status: :accepted
    else
      render json: { errors: @user.errors.full_messages }, status: :not_acceptable
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      render json: { user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :not_acceptable
    end
  end

  def destroy
    @user = User.find(params[:id])
    Relationship.where(follower_id: @user.id).destroy_all
    Relationship.where(followee_id: @user.id).destroy_all
    @user.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :profile_url)
  end

end
