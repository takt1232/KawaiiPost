class AdminController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
  end

  def posts
  end

  def comments
  end
end
