class API::V1::CommentsController < ApplicationController 
  before_action :set_post
  before_action :authenticate_token!

  def index
    render json: @post.comments
  end

  def show
    comment = @post.comments.find(params[:id])
    render json: comment
  rescue
    render json: {errors: ["Comment could not be found"]}, status: 404 
  end

  def set_post
    @post = Post.includes(:comments).find(params[:post_id])
  rescue
    render json: {errors: ["Post could not be found"]}, status: 404 
  end

end