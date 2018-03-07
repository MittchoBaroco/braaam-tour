class Admin::BookingDatesController < ApplicationController
  # before_action :authenticate_manager!
  before_action :set_admin_booking_date,
                only: [:show, :edit, :update, :destroy, :signup, :cancel]

  def index
    @admin_booking_dates = BookingDate.all
  end

  def show
  end

  def new
    @admin_booking_date = BookingDate.new
  end

  def edit
  end

  def create
    @admin_booking_date = BookingDate.new(admin_booking_date_params)

    respond_to do |format|
      if @admin_booking_date.save
        format.html { redirect_to admin_booking_date_path(@admin_booking_date), notice: 'Tour date was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_booking_date_path(@admin_booking_date) }
      else
        format.html { render :new }
        format.json { render json: @admin_booking_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/booking_dates/1
  # PATCH/PUT /admin/booking_dates/1.json
  def update
    respond_to do |format|
      if @admin_booking_date.update(admin_booking_date_params)
        format.html { redirect_to admin_booking_date_path(@admin_booking_date), notice: 'Tour date was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_booking_date_path(@admin_booking_date) }
      else
        format.html { render :edit }
        format.json { render json: @admin_booking_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/booking_dates/signup/1
  # PATCH/PUT /admin/booking_dates/signup/1.json
  def signup
    respond_to do |format|
      # TODO: add a company password check for commit?
      tour = @admin_booking_date.tour
      company, new_params = BookingStrategy.new(params: get_booking_info,
                                                action: :signup).run
      if company and @admin_booking_date.update( new_params )
        # TODO: email company of sucessful booking signup
        format.html { redirect_to admin_booking_dates_path,
                                  notice: 'Date was successfully booked.' }
        format.json { render :show, status: :ok, location: tour }
      elsif company.blank?
        format.html { redirect_to admin_booking_dates_path,
                                  alert: 'Booking failed - company not found' }
        format.json { render json: @admin_booking_date.errors,
                                  status: :unprocessable_entity }
      else
        format.html { redirect_to admin_booking_dates_path,
                                  alert: 'Booking failed - unexpected error' }
        format.json { render json: @admin_booking_date.errors,
                                  status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/booking_dates/signup/1
  # PATCH/PUT /admin/booking_dates/signup/1.json
  def cancel
    respond_to do |format|
      # TODO: add a company password check for commit?
      tour = @admin_booking_date.tour
      company, new_params = BookingStrategy.new(params: get_booking_info,
                                                action: :cancel).run
      if company and @admin_booking_date.update( new_params )
        # TODO: email company of sucessful booking signup
        format.html { redirect_to admin_booking_dates_path,
                                  notice: 'Date was successfully cancelled.' }
        format.json { render :show, status: :ok, location: tour }
      elsif company.blank?
        format.html { redirect_to admin_booking_dates_path,
                                  alert: 'cancellation failed - company not found' }
        format.json { render json: @admin_booking_date.errors,
                                  status: :unprocessable_entity }
      else
        format.html { redirect_to admin_booking_dates_path,
                                  alert: 'cancellation failed - unexpected error' }
        format.json { render json: @admin_booking_date.errors,
                                  status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/booking_dates/1
  # DELETE /admin/booking_dates/1.json
  def destroy
    @admin_booking_date.destroy
    respond_to do |format|
      format.html { redirect_to admin_booking_dates_url, notice: 'Tour date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_booking_date
      @admin_booking_date = BookingDate.find(params[:id])
    end

    def get_booking_info
      { id: params[:id],
        company_id: params[:admin_booking_date][:company_id],
        company_email: params[:admin_booking_date][:company_email],
      }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_booking_date_params
      params.fetch(:admin_booking_date, {}).permit(:id, :day, :tour_id)
    end
end
