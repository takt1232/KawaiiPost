class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [ :show, :destroy ]

  def index
    @posts = Post.includes(:user)
  end

  def show
    @comments = @post.comments.includes(:user)
  end

  def destroy
    if @post.destroy
      redirect_to admin_post_path, notice: "Post was successfully deleted"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def bulk_delete
    if params[:post_ids].present?
      Post.where(id: params[:post_ids]).destroy_all
      redirect_to admin_posts_index_path, notice: "Selected posts have been deleted."
    else
      redirect_to admin_posts_index_path, alert: "No post selected."
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
