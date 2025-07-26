class PagesController < ApplicationController
  before_action :authenticate_user!, only: [ :home ]

  def index
  end
end
