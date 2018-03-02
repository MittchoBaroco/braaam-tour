class Admin::TourDatesController < ApplicationController
  before_action :set_admin_tour_date, only: [:show, :edit, :update, :destroy]

  # GET /admin/tour_dates
  # GET /admin/tour_dates.json
  def index
    @admin_tour_dates = TourDate.all
  end

  # GET /admin/tour_dates/1
  # GET /admin/tour_dates/1.json
  def show
  end

  # GET /admin/tour_dates/new
  def new
    @admin_tour_date = TourDate.new
  end

  # GET /admin/tour_dates/1/edit
  def edit
  end

  # POST /admin/tour_dates
  # POST /admin/tour_dates.json
  def create
    @admin_tour_date = TourDate.new(admin_tour_date_params)

    respond_to do |format|
      if @admin_tour_date.save
        # format.html { redirect_to @admin_tour_date, notice: 'Tour date was successfully created.' }
        # format.json { render :show, status: :created, location: @admin_tour_date }
        format.html { redirect_to admin_tour_date_path(@admin_tour_date), notice: 'Tour date was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_tour_date_path(@admin_tour_date) }
      else
        format.html { render :new }
        format.json { render json: @admin_tour_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tour_dates/1
  # PATCH/PUT /admin/tour_dates/1.json
  def update
    respond_to do |format|
      if @admin_tour_date.update(admin_tour_date_params)
        # format.html { redirect_to @admin_tour_date, notice: 'Tour date was successfully updated.' }
        # format.json { render :show, status: :ok, location: @admin_tour_date }
        format.html { redirect_to admin_tour_date_path(@admin_tour_date), notice: 'Tour date was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_tour_date_path(@admin_tour_date) }
      else
        format.html { render :edit }
        format.json { render json: @admin_tour_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tour_dates/1
  # DELETE /admin/tour_dates/1.json
  def destroy
    @admin_tour_date.destroy
    respond_to do |format|
      format.html { redirect_to admin_tour_dates_url, notice: 'Tour date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_tour_date
      @admin_tour_date = TourDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_tour_date_params
      params.fetch(:admin_tour_date, {}).permit(:day, :tour_id)
    end
end
