class PlacesController < ApplicationController
  before_filter :require_current_place, :only => [:show, :edit, :update, :destroy]
  def index
  end

  def show
  end

  def edit
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.create(place_params)
    if @place.valid?
      redirect_to places_path
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def update
    current_place.update_attributes(place_params)
    if current_place.valid?
      redirect_to places_path
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    current_place.destroy
    redirect_to places_path
  end


  private
  def place_params
    params.require(:place).permit(:name, :description, :lat, :lng)
  end

  helper_method :current_place
  def current_place
    @current_place ||= Place.find_by_id(params[:id])
  end

  def require_current_place
    render_not_found unless current_place.present?
  end
end
