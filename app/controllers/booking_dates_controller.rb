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

      # only process a new booking if no other company has already booked
      unless @booking_date.company.blank?
        format.html { redirect_to @tour,
                                    alert: 'Sorry, date already booked.' }
        format.json { render :show, status: :date_already_booked,
                                    location: @tour }
      end

      # find the company and create booking params for saving
      company, new_params = BookingStrategy.new(params: get_booking_info,
                                                action: :signup).run

      # if the company can be found and booking date succesfully updates
      if company and @booking_date.update( new_params )
        BookingMailer.booking_confirmation(@booking_date.company, @booking_date.day.to_s, @tour.title).deliver_later
        BookingMailer.admins_notification(@booking_date.company, @booking_date.day.to_s, @tour.title).deliver_later
        format.html { redirect_to @tour, notice: 'Date was successfully booked.' }
        format.json { render :show, status: :ok, location: @tour }
      end

      # the company id or email couldn't be found in the list of partner companies
      if company.blank?
        format.html { flash.now[:alert] = 'Company not found'; render :book }
        format.json { render json: @booking_date.errors,
                                  status: :unprocessable_entity }
      end

      # who knows what went wrong if we got here - log and report this problem
      # TODO: configure rollbar (& get an account)
      # Rollbar.error("Unknown Booking error -- BookingDate: #{@booking_date}, saving errors: #{@booking_date.errors.messages} - incomming params: #{booking_date_params}, processsed params #{new_params}", saving_errors: @booking_date.errors.messages)
      Rails.logger.error "Unknown Booking error -- BookingDate: #{@booking_date}, saving errors: #{@booking_date.errors.messages}\n\t- incomming params: #{booking_date_params}, processsed params #{new_params}"
      format.html { flash.now[:alert] = 'Unexpected error'; render :book }
      format.json { render json: @booking_date.errors,
                                  status: :unprocessable_entity }
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
