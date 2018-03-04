class BookingDatesController < ApplicationController
  skip_before_action :authenticate_manager!
  before_action :set_tour_booking_info, only: [:commit]

  # PATCH/PUT /booking_dates/1
  # PATCH/PUT /booking_dates/1.json
  def commit
    respond_to do |format|
      # if @booking_date.update(booking_date_params)
      if @booking_date.update(company_id: @company_id)
        format.html { redirect_to @tour,
                      notice: 'Tour booking date was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_booking_info
      @tour         = Tour.find(params[:tour_id])
      @booking_date = BookingDate.find(params[:id])
      @company_id   = params[:company_id]
      @company_id   = Company.find_by(email: params[:email]).id if params[:email]
    end

    # Never trust parameters from the scary internet, use the white list
    def booking_date_params
      params.require(:booking_date).permit(:id, :tour_id, :company_id, :email)
    end

end
