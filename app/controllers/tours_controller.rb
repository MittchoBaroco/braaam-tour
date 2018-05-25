class ToursController < ApplicationController
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
    # DO NOT USE ORDER('booking_dates.day ASC')
    # -- order and limit conflict with includes
    # using limit 3 for now since show page has space for multiples of 3
    @tours = Tour.show_collection(@tour.id).limit(6)
    @comments = @tour.comments.order(created_at: :desc)
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
