class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :edit, :update, :destroy, :show ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @posts = Post.order(published_date: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  def show
    @post_comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = @post.comments.new
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :published_date)
  end

  def authorize_user!
    unless current_user == @post.user
      redirect_to posts_path, alert: "You are not authorized to perform this action."
    end
  end
end
