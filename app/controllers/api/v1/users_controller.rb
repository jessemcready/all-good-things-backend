class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all.map do |user|
      UserSerializer.new(user)
    end
    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render json: UserSerializer.new(@user), status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user), status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      render json: UserSerializer.new(@user), status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def delete
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
