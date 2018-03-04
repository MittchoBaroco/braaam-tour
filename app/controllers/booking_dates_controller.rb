class BookingDatesController < ApplicationController
  skip_before_action :authenticate_manager!
  before_action :set_tour_booking_info, only: [:commit]

  # PATCH/PUT /booking_dates/1
  # PATCH/PUT /booking_dates/1.json
  def commit
    respond_to do |format|
      # TODO: add a password check for commit?
      # check that email was found in list of approved companies
      if @company and @booking_date.update(company_id: @company.id)
        format.html { redirect_to @tour,
                      notice: 'Tour booking date was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      elsif @company.blank?
        # format.html { render :edit }
        format.html { redirect_to @tour,
                      notice: 'Tour booking failed - company not found' }
        format.json { render json: @booking_date.errors,
                      status: :unprocessable_entity }
      else
        format.html { redirect_to tours_path,
                      notice: 'Tour booking failed - booking date not found' }
        format.json { render json: @booking_date.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_booking_info
      @booking_date = BookingDate.find(params[:id])
      @tour         = @booking_date.tour
      begin
        if params[:booking_date][:company_id]
          @company      = Company.find(params[:booking_date][:company_id])
        end
        if params[:booking_date][:company_email]
          @company      = Company.find_by(email: params[:booking_date][:company_email])
        end
      rescue ActiveRecord::RecordNotFound
        @company = nil
      end
    end

    # Never trust parameters from the scary internet, use the white list
    def booking_date_params
      params.require(:booking_date).permit(:id, :company_id, :company_email)
    end

end
