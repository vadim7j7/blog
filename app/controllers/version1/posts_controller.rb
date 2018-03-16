module Version1
  class PostsController < ApplicationController
    skip_before_action :authenticate_request, only: %i[index show]
    before_action :load_post, only: %i[show update destroy]

    def index
      resources = Post.order(created_at: :desc)
                      .paginate(page: params[:page], per_page: 20)

      render json: resources, meta: pagination(resources)
    end

    def show
      render json: @post
    end

    def create
      authorize! :create, Post

      post = @current_user.posts.build(post_params)
      post.save!

      render json: post
    end

    def update
      authorize! :update, @post

      @post.update!(post_params)

      render json: @post
    end

    def destroy
      authorize! :destroy, @post

      @post.destroy!

      head :no_content
    end

    private

    def load_post
      @post = Post.find_by_id!(params[:id])
    end

    def post_params
      params.permit(:title, :body, :tag_list)
    end
  end
end
