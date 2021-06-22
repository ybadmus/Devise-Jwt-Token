class API::V1::PostsController < ApplicationController 
  before_action :set_action, only: %i[show edit update destroy]

  def index
    render json: Post.all
  end

  def show
    render json: @post, include: ['comments']
  end

  def create 
    post = current_user.posts.build(post_params)
    if post.save
      render json: post, status: 201
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  private 
    
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end

end