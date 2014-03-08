class UsersController < ApplicationController
  before_filter :require_selected_user

  def show
  end

  private

  helper_method :selected_user
  def selected_user
    @selected_user ||= User.find_by_id(params[:id])
  end

  def require_selected_user
    render_not_found unless selected_user
  end

end
