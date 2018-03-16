class ApplicationController < ActionController::API
  before_action :authenticate_request

  include CanCan::ControllerAdditions
  include ExceptionHandler

  attr_reader :current_user

  def pagination(obj)
    {
      pagination: {
        perPage: obj.per_page,
        totalPages: obj.total_pages,
        totalObjects: obj.total_entries
      }
    }
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result

    error = I18n.t('auth.errors.not_authorized')
    render json: { error: error }, status: :unauthorized unless @current_user
  end
end
