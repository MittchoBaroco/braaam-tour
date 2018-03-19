class ToursController < ApplicationController
  skip_before_action :authenticate_manager!
  before_action :set_tour, only: [:show]

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.current.with_attached_cover_image
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    # component require a collection to show - for the bottom of the show page
    @tours = (Tour.current.with_attached_cover_image - @tour)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.fetch(:tour, {})
    end
end
