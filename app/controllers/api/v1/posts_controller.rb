class API::V1::PostsController < ApplicationController 
  before_action :authenticate_user!

  def index
    render json: Post.includes(:user).all, each_serializer: PostWithoutCommentsSerializer
  end

  def show
    @post = set_post_show
    render json: @post
  end

  def create 
    post = current_user.posts.build(post_params)

    if post.save
      render json: post, status: 201
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  def update
    @post = set_post
    if @post.update(post_params)
      render json: @post, status: 200
    else
      render json: { errors: @post.errors }, status: 422
    end
  end

  def destroy
    @post = set_post
    @post.destroy
    head 200
  end

  private 
    
    def set_post
      Post.find(params[:id])
    rescue
      render json: {errors: ["Post could not be found"]}, status: 404 
    end

    def set_post_show
      Post.includes(comments: [:user]).find(params[:id])
    rescue
      render json: {errors: ["Post could not be found"]}, status: 404 
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end

end