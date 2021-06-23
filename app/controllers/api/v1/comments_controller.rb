class API::V1::CommentsController < ApplicationController 
  before_action :set_post, only: %i[index create]
  before_action :set_comment, only: %i[show]
  before_action :authenticate_token!

  def index
    render json: @post.comments
  end

  def show
    render json: @comment, include: ['user', 'post']
  end

  def create 
    comment = @post.comments.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      render json: comment, status: 201
    else
      render json: { errors: comment.errors }, status: 422
    end
  end

  private

    def set_post
      @post = Post.includes(:comments).find(params[:post_id])
    rescue
      render json: {errors: ["Post could not be found"]}, status: 404 
    end

    def set_comment
      @comment = Comment.find(params[:id])
    rescue
      render json: {errors: ["Comment could not be found"]}, status: 404 
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

end