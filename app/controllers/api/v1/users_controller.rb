class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    @users = User.order(created_at: :desc).map do |user|
      UserSerializer.new(user)
    end
    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render json: { user: UserSerializer.new(@user) }, status: :accepted
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
      render json: UserSerializer.new(@user), status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :not_acceptable
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end

end
