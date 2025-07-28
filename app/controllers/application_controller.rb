class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path
    elsif resource.is_a?(User)
      posts_path
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    elsif resource_or_scope == :user
      root_path
    else
      super
    end
  end
end
