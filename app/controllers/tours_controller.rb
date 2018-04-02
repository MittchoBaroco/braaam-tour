class ToursController < ApplicationController
  skip_before_action :authenticate_manager!
  before_action :set_tour, only: [:show]

  # GET /tours
  # GET /tours.json
  def index
    # today and in future with a cover_image
    @tours = Tour.index_collection
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    # collection of today and future tours for the bottom of the show page
    # @tours = Tour.current.with_image - [@tour]
    # byebug
    # @tours = Tour.current.with_image.where.not(id: @tour.id)
    @tours = Tour.show_collection(@tour.id)
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
