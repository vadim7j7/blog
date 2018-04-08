module Version1
  class AuthController < ApplicationController
    skip_before_action :authenticate_request, only: %i[login registration]

    def index
      render json: @current_user.profile
    end

    def login
      authenticate(params[:email], params[:password])
    end

    def registration
      user = User.new(user_params)
      create_user(user)
    end

    private

    # @param[String] email
    # @param[String] password
    def authenticate(email, password)
      command = AuthenticateUser.call(email, password)

      if command.success?
        render json: {
          accessToken: command.result,
          message: I18n.t('auth.success.authorized')
        }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end

    # @param[User] user
    def create_user(user)
      if user.save
        token = JsonWebToken.encode(user_id: user.id)

        response = {
          accessToken: token,
          message: I18n.t('auth.success.registration')
        }
        render json: response, status: :created
      else
        render json: user.errors, status: :bad_request
      end
    end

    def user_params
      params.permit(
        :email,
        :password,
        :password_confirmation,
        profile_attributes: %i[first_name last_name title description]
      )
    end
  end
end
