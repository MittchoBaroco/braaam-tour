class BookingDatesController < ApplicationController
  skip_before_action :authenticate_manager!
  before_action :set_booking_date, only: [:signup]

  # PATCH/PUT /booking_dates/1
  # PATCH/PUT /booking_dates/1.json
  def signup
    respond_to do |format|
      # TODO: add a company password check for commit?
      
      tour = @booking_date.tour

      info =  { id: params[:id],
                company_id: params[:booking_date][:company_id],
                company_email: params[:booking_date][:company_email],
              }
      company, new_params = BookingStrategy.new(params: info,
                                                action: :signup).run
      if company and @booking_date.update( new_params )
        # TODO: email company of sucessful booking signup
        format.html { redirect_to tour,
                                  notice: 'Date was successfully booked.' }
        format.json { render :show, status: :ok, location: tour }
      elsif company.blank?
        # format.html { render :edit }
        format.html { redirect_to tour,
                                  alert: 'Booking failed - company not found' }
        format.json { render json: @booking_date.errors,
                                  status: :unprocessable_entity }
      else
        format.html { redirect_to tours_path,
                                  alert: 'Booking failed - unexpected error' }
        format.json { render json: @booking_date.errors,
                                  status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking_date
      @booking_date = BookingDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, use the white list
    def booking_date_params
      params.require(:booking_date).permit(:id).merge(:company_email)
    end

end
