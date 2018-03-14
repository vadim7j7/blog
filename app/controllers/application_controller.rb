class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  include ExceptionHandler

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message },
           status: :forbidden
  end

  private

  def authenticate_request
    @current_user = Auth::AuthorizeApiRequest.call(request.headers).result

    error = I18n.t('auth.errors.not_authorized')
    render json: { error: error }, status: :unauthorized unless @current_user
  end
end
