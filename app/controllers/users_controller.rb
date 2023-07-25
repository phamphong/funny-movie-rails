class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]

  # POST /register
  def register
    @user = User.create(user_params)
    if @user.save
      response = { message: 'User created successfully'}
      render json: response, status: :created
    else
      render json: @user.errors, status: 500
    end
  end

  # POST /login
  def login
    authenticate params[:email], params[:password]
  end

  # GET /user-info
  def userInfo
    render json: {
      email: @current_user.email,
      message: 'You have passed authentication and authorization test'
    }
  end

  #PRIVATE
  private
  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: JsonWebToken.encode(user_id: command.result.id),
        email: command.result.email,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(
      :name,
      :email,
      :password
    )
  end

end
