class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_current_place, :only => :create

  def create
    @comment = current_place.comments.create(
      comment_params.merge(:user => current_user)
    )
    
    if @comment.valid?
      redirect_to place_path current_place
    else
      render 'places/show', :status => :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:message, :rating)
  end

  def require_current_place
    render_not_found unless current_place
  end

  helper_method :current_place
  def current_place
    @current_place ||= Place.find_by_id(params[:place_id])
  end
end
