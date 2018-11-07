class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    # encode the payload with this secret string
    JWT.encode(payload, 'my_secret')
  end

  def auth_header
    # get the header that has key 'Authorization'
    request.headers['Authorization']
  end

  def decoded_token(token)
    # if we have an auth header
    if auth_header
      # split it
      token = auth_header.split(' ')[1]
      begin
        # and try to decode that token with our secret string we encoded with
        JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized
    unless logged_in?
  end

end
