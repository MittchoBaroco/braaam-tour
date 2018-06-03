class Admin::ToursController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_admin_tour, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET /admin/tours
  # GET /admin/tours.json
  def index
    @admin_tours = Tour.all
  end

  # GET /admin/tours/1
  # GET /admin/tours/1.json
  def show
  end

  # GET /admin/tours/new
  def new
    @admin_tour = Tour.new
  end

  # GET /admin/tours/1/edit
  def edit
  end

  # POST /admin/tours
  # POST /admin/tours.json
  def create
    @admin_tour = Tour.new(admin_tour_params)

    #fix currency for franch locale
    if I18n.locale.eql?(:fr)
      correct_money_normal = admin_tour_params[:price_normal].gsub(".", ",")
      correct_money_braaam = admin_tour_params[:price_braaam].gsub(".", ",")
      @admin_tour.price_normal = correct_money_normal
      @admin_tour.price_braaam = correct_money_braaam
    end

    respond_to do |format|
      if @admin_tour.save
        # format.html { redirect_to @admin_tour, notice: 'Tour was successfully created.' }
        # format.json { render :show, status: :created, location: @admin_tour }
        format.html { redirect_to admin_tour_path(@admin_tour), notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: admin_tour_path(@admin_tour) }
      else
        format.html { render :new }
        format.json { render json: @admin_tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tours/1
  # PATCH/PUT /admin/tours/1.json
  def update
    respond_to do |format|
      if @admin_tour.update(admin_tour_params)
        # format.html { redirect_to @admin_tour, notice: 'Tour was successfully updated.' }
        # format.json { render :show, status: :ok, location: @admin_tour }
        format.html { redirect_to admin_tour_path(@admin_tour), notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: admin_tour_path(@admin_tour) }
      else
        format.html { render :edit }
        format.json { render json: @admin_tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tours/1
  # DELETE /admin/tours/1.json
  def destroy
    @admin_tour.destroy
    respond_to do |format|
      format.html { redirect_to admin_tours_url, notice: 'Tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_tour
      @admin_tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_tour_params
      # byebug
      params.require(:tour).permit(
        :title, :description, :video_uri, :tech_help, :housing, :catering,
        :currency, :price_normal, :price_braaam,
        :cover_image, :tech_sheet, :tour_caption, :artist_country,
        awards_attributes: [:caption, :institution, :country, :award_year, :id, :_destroy],
        booking_dates_attributes: [:day, :company, :close, :id, :_destroy],
        comments_attributes: [:comment_body, :author_name, :id, :_destroy]
      )
    end
end
