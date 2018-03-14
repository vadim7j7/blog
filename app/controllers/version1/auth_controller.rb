module Version1
  class AuthController < ApplicationController
    skip_before_action :authenticate_request, only: %i[login registration]

    def index
      render json: {
          email: @current_user.email
      }
    end

    def login
      authenticate(params[:email], params[:password])
    end

    def registration
      user = User.new(user_params)

      if user.save
        response = { message: I18n.t('auth.success.registration') }
        render json: response, status: :created
      else
        render json: user.errors, status: :bad_request
      end
    end

    def new_password
      head :no_content
    end

    private

    def authenticate(email, password)
      command = AuthenticateUser.call(email, password)

      if command.success?
        render json: {
          access_token: command.result,
          message: I18n.t('auth.success.authorized')
        }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end

    def user_params
      params.permit(:email, :password)
    end
  end
end