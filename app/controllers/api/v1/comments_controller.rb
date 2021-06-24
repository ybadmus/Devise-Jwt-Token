class API::V1::CommentsController < ApplicationController 
  before_action :set_comment, only: %i[show update destroy]
  before_action :authenticate_user!

  def index
    @post = set_post
    render json: @post.comments
  end

  def show
    @comment = set_comment
    render json: @comment
  end

  def create 
    @post = set_post
    comment = @post.comments.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      render json: comment, status: 201
    else
      render json: { errors: comment.errors }, status: 422
    end
  end

  def update
    @comment = set_comment
    if @comment.update(comment_params)
      render json: @comment, status: 200
    else
      render json: { errors: @comment.errors }, status: 422
    end
  end

  def destroy
    @comment = set_comment
    @comment.destroy
    head 200
  end

  private

    def set_post
      Post.includes(comments: [:user]).find(params[:post_id])
    rescue
      render json: {errors: ["Post could not be found"]}, status: 404 
    end

    def set_comment
      Comment.find(params[:id])
    rescue
      render json: {errors: ["Comment could not be found"]}, status: 404 
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

end