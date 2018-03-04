class BookingDatesController < ApplicationController
  skip_before_action :authenticate_manager!
  before_action :set_tour_booking_info, only: [:commit]

  # PATCH/PUT /booking_dates/1
  # PATCH/PUT /booking_dates/1.json
  def commit
    respond_to do |format|
      if @booking_date.update(booking_date_params)
        format.html { redirect_to @tour, notice: 'Tour booking date was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_booking_info
      @tour              = Tour.find(params[:tour_id])
      @booking_date = BookingDate.find(params[:id])
      begin
        @company_id      = Company.find_by(params[:company_email])
      rescue
        format.html { redirect_to @tour, alert: 'Company email not recognized - no booking made' }
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_date_params
      params.require(:booking_date).permit(:id, :tour_id, :company_email)
    end

end
