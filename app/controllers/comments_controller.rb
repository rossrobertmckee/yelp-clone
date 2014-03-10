class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_current_place, :only => :create
  before_filter :require_current_comment, :only => :destroy
  before_filter :require_current_comment_destroyable, :only => :destroy

  def destroy
    place = current_comment.place
    current_comment.destroy
    redirect_to place_path(place)
  end

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
  def require_current_comment
    render_not_found unless current_comment
  end

  def current_comment
    @current_comment ||= Comment.find_by_id(params[:id])
  end

  def require_current_comment_destroyable
    render_not_found(:forbidden) unless current_comment.controlled_by?(current_user)
  end


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
