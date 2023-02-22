class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy, :like_post, :new] #except: [:index, :search, :create]
  before_action :set_like, only: :like_post

  def index
    # current_user.id
    @posts = Post.all.includes(:likes)
    render json: @posts
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages, status: :unprocessable_entity 
    end
  end

  def update
    current_user.id
    # @post = Post.find(params[:id])
    if @post.update(post_params)
    render json: @post
    else
      render json: @post.errors.full_messages
    end
  end

  def destroy
    current_user.id
    # @post = Post.find(params[:id])
    @post.destroy
    # redirect_to "/"
    render json: "deleted......."
   end

  def like_post
  # @post = Post.find(params[:id])
  # current_user_like = @post.likes.find_by(user_id: current_user.id)

  if current_user_like
    current_user_like.update(active: false)

  else
    @post.likes.create(user_id: current_user.id)
  end

  redirect_to root_path
  end

  def search
    if params[:search].blank?
      redirect_to post_path
    else
      @posts = Post.all.where("title LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  private                           
  def post_params
    params.require(:post).permit(:title, :description, :image, :category_id, :active)
  end

  def set_post
    @post = Post.find(params[:id])
    # render json: @post
    render json: {message: "post not found"}, status: :not_found unless @post
    end

  def set_like
    current_user_like = @post.likes.find_by(user_id: current_user.id)
  end
end
