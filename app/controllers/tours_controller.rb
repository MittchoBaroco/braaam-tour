class ToursController < ApplicationController
  before_action :authenticate_company!, only: [:new, :create, :edit, :update]
  before_action :set_tour, only: [:show, :edit, :update]

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

  def new
    @tour = Tour.new
  end

  # POST /admin/tours
  # POST /admin/tours.json
  def create
    @tour = Tour.new(tour_params)
    @tour.creator = current_company

    #fix currency for franch locale
    if I18n.locale.eql?(:fr)
      correct_money_normal = tour_params[:price_normal].gsub(".", ",")
      correct_money_braaam = tour_params[:price_braaam].gsub(".", ",")
      @tour.price_normal = correct_money_normal
      @tour.price_braaam = correct_money_braaam
    end

    respond_to do |format|
      if @tour.save
        format.html { redirect_to tour_path(@tour), notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: tour_path(@tour) }
      else
        format.html { render :new }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  # PATCH/PUT /admin/tours/1
  # PATCH/PUT /admin/tours/1.json
  def update
    @tour.assign_attributes(tour_params)

    #fix currency for franch locale
    if I18n.locale.eql?(:fr)
      correct_money_normal = tour_params[:price_normal].gsub(".", ",")
      correct_money_braaam = tour_params[:price_braaam].gsub(".", ",")
      @tour.price_normal = correct_money_normal
      @tour.price_braaam = correct_money_braaam
    end

    respond_to do |format|
      if @tour.save
        format.html { redirect_to tour_path(@tour), notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: tour_path(@tour) }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(
        :title, :description, :video_uri, :housing, :catering, :artist_country,
        :cover_image, :tech_sheet, :tour_caption, :price_normal, :price_braaam,
        awards_attributes: [:caption, :institution, :country, :award_year, :id, :_destroy],
        booking_dates_attributes: [:day, :company, :close, :id, :_destroy],
        comments_attributes: [:comment_body, :author_name, :id, :_destroy]
      )
    end
end
