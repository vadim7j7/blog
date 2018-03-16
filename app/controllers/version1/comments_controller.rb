module Version1
  class CommentsController < ApplicationController
    before_action :load_comment, except: :create

    def create
      authorize! :create, Comment

      post = Post.find_by_id!(params[:post_id])
      comment = post.comments.build(comment_params)
      comment.user = @current_user
      comment.parent = Comment.find_by_id!(params[:parent_id]) if params[:parent_id]
      comment.save!

      render json: comment
    end

    def update
      authorize! :update, @comment

      @comment.update!(comment_params)

      render json: @comment
    end

    def destroy
      authorize! :update, @comment

      @comment.destroy!

      head :no_content
    end

    private

    def load_comment
      @comment = Comment.find_by_id!(params[:id])
    end

    def comment_params
      params.permit(:message)
    end
  end
end
