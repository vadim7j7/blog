Rails.application.routes.draw do
  namespace :version1 do
    resources :auth, only: :index do
      collection do
        post :login
        post :registration
      end
    end

    resources :posts

    resources :comments, except: %i[index show]
  end
end
