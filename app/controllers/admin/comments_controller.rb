class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [ :destroy, :edit, :update ]
  before_action :set_comment, only: [ :destroy, :edit, :update ]

  def index
    @comments = Comment.all

    if params[:query].present?
      query = "%#{params[:query]}%"
      @comments = @comments.where("content ILIKE ? OR user ILIKE ?", query, query)
    end

    @comments = @comments.order(created_at: :desc)
  end

  def edit

  end

  def update
    if @comment.update(comment_params)
      redirect_to admin_post_path(@post), notice: "Comment updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to admin_post_path(@post), notice: "Comment deleted successfully"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def bulk_delete
    if params[:comment_ids].present?
      Comment.where(id: params[:comment_ids]).destroy_all
      redirect_to admin_comments_index_path, notice: "Selected comments have been deleted."
    else
      redirect_to admin_comments_index_path, alert: "No comments selected."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
