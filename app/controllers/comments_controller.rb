class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :create ]
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def edit
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@comment.post), notice: "Comment posted!", status: :see_other
    else
      redirect_to post_path(@comment.post), alert: "Failed to post comment.", status: :see_other
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: "Comment was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = @comment.post
    @comment.destroy
    redirect_to post_path(@comment.post), notice: "Comment was successfully deleted.", status: :see_other
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_user!
    unless current_user == @comment.user
      redirect_to post_path(@comment.post), alert: "You are not authorized to perform this action."
    end
  end
end
