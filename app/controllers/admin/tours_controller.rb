class Admin::ToursController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_tour, only: [:show, :edit, :update, :destroy, :highlight, :remove_highlight]
  layout "admin"

  # GET admin/tours
  # GET admin/tours.json
  def index
    @tours = Tour.all
  end

  # GET admin/tours/1
  # GET admin/tours/1.json
  def show
  end

  # GET admin/tours/new
  def new
    @tour = Tour.new
  end

  # GET admin/tours/1/edit
  def edit
  end

  # POST admin/tours
  # POST admin/tours.json
  def create
    @tour = Tour.new(tour_params)

    #fix currency for french locale
    if I18n.locale.eql?(:fr)
      correct_money_normal = tour_params[:price_normal].gsub(".", ",")
      correct_money_braaam = tour_params[:price_braaam].gsub(".", ",")
      @tour.price_normal = correct_money_normal
      @tour.price_braaam = correct_money_braaam
    end

    respond_to do |format|
      if @tour.save
        format.html { redirect_to [:admin, @tour], notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: @tour }
      else
        format.html { render :new }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/tours/1
  # PATCH/PUT admin/tours/1.json
  def update
    @tour.assign_attributes(tour_params)

    #fix currency for french locale
    if I18n.locale.eql?(:fr)
      if tour_params[:price_normal].present?
        correct_money_normal = tour_params[:price_normal].gsub(".", ",")
        @tour.price_normal = correct_money_normal
      end

      if tour_params[:price_braaam].present?
        correct_money_braaam = tour_params[:price_braaam].gsub(".", ",")
        @tour.price_braaam = correct_money_braaam
      end
    end

    respond_to do |format|
      if @tour.save
        format.html { redirect_to [:admin, @tour], notice: 'Tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/tours/1
  # DELETE admin/tours/1.json
  def destroy
    @tour.destroy
    respond_to do |format|
      format.html { redirect_to admin_tours_url, notice: 'Tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT admin/tours/highlight/1
  # PATCH/PUT admin/tours/highlight/1.json
  def highlight
    respond_to do |format|
      if @tour.update_attribute(:highlighted_at, DateTime.now)
        format.html { redirect_to [:admin, @tour], notice: 'Tour was successfully highlighted.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/tours/remove_highlight/1
  # PATCH/PUT admin/tours/remove_highlight/1.json
  def remove_highlight
    respond_to do |format|
      if @tour.update_attribute(:highlighted_at, "")
        format.html { redirect_to [:admin, @tour], notice: 'Tour was successfully unhighlighted.' }
        format.json { render :show, status: :ok, location: @tour }
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
        :tour_staff_number, :tour_artist_email, :tour_artist_phone, :highlighted_at,
        awards_attributes: [:caption, :institution, :country, :award_year, :id, :_destroy],
        booking_dates_attributes: [:day, :company, :close, :id, :_destroy],
        comments_attributes: [:comment_body, :author_name, :id, :_destroy]
      )
    end
end
