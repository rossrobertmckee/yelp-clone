class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_current_user_is_admin

  private

  def require_current_user_is_admin
      render_not_found :unauthorized unless current_user.admin
  end
end
