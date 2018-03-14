Rails.application.routes.draw do
  namespace :version1 do
    resources :auth, only: :index do
      collection do
        post :login
        post :registration
        put :new_password
      end
    end
  end
end
