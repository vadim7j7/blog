module Version1
  class ProfilesController < ApplicationController
    def show
      render json: @current_user.profile
    end

    def update
      profile = @current_user.profile
      profile.update(profile_params)

      render json: profile
    end

    private

    def profile_params
      params.permit(
        :email,
        :first_name,
        :last_name,
        :title,
        :description,
        :avatar
      )
    end
  end
end
