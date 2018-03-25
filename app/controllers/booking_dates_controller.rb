class BookingDatesController < ApplicationController
  skip_before_action :authenticate_manager!
  before_action :set_booking_date, only: [:signup, :book]

  def book
    @tour = @booking_date.tour
  end

  # PATCH/PUT /booking_dates/signup/1
  # PATCH/PUT /booking_dates/signup/1.json
  def signup
    respond_to do |format|
      # TODO: add a company password check for commit?
      @tour = @booking_date.tour
      company, new_params = BookingStrategy.new(params: get_booking_info,
                                                action: :signup).run
      if company and @booking_date.update( new_params )
        # TODO: email company of sucessful booking signup
        format.html do
          BookingMailer.booking_confirmation(@booking_date.company, @booking_date.day.to_s, @tour.title).deliver_later
          BookingMailer.admins_notification(@booking_date.company, @booking_date.day.to_s, @tour.title).deliver_later
          redirect_to @tour, notice: 'Date was successfully booked.'
        end
        format.json { render :show, status: :ok, location: @tour }
      elsif company.blank?
        # format.html { render :edit }
        format.html { flash.now[:alert] = 'Company not found'; render :book }
        format.json { render json: @booking_date.errors,
                                  status: :unprocessable_entity }
      else
        format.html { flash.now[:alert] = 'Unexpected error'; render :book }
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

    def get_booking_info
      { id: params[:id],
        company_id: params[:booking_date][:company_id],
        company_email: params[:booking_date][:company_email],
      }
    end

    # Never trust parameters from the scary internet, use the white list
    def booking_date_params
      params.require(:booking_date).permit(:id)
    end

end
