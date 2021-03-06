class ToursController < ApplicationController
  before_action :authenticate_company!, only: [:new, :create, :edit, :update]
  before_action :set_tour, only: [:show, :edit, :update]

  # GET /tours
  # GET /tours.json
  def index
    # today and in future with a cover_image
    @tours_summer = Tour.summer.index_collection
    @tours_winter = Tour.winter.index_collection
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    @tours = Tour.summer.show_collection(@tour.id) if @tour.summer_tour?
    @tours = Tour.winter.show_collection(@tour.id) if @tour.winter_tour?
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
    if I18n.locale.eql?(:fr) and Rails.env.eql?("development")
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
    if I18n.locale.eql?(:fr) and Rails.env.eql?("development")
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
        :title, :description, :video_uri, :housing, :catering, :tour_artist_name,
        :cover_image, :tech_sheet, :tour_caption, :price_normal, :price_braaam,
        :tour_staff_number, :tour_artist_email, :tour_artist_phone,
        awards_attributes: [:caption, :institution, :country, :award_year, :id, :_destroy],
        booking_dates_attributes: [:day, :company, :close, :id, :_destroy],
        comments_attributes: [:comment_body, :author_name, :id, :_destroy]
      )
    end
end
