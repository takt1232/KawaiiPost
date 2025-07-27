class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts_count = Post.count
    @comments_count = Comment.count
    @users_count = User.count

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
