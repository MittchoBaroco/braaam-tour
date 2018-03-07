# # Booking System
# # usage:
# company, new_params =
#      BookingInfo.new(params: params, action: :signup).run
#
# valid actions include:
# * :signup
# * :cancel
#
# if @booking_date.update( new_params )
#   # email company of successful booking
#   format.html { redirect_to tour, notice: 'Date was successfully booked.' }
# end

class BookingStrategy

  attr_reader :params, :action, :company

  def initialize(params:, action: :signup)
    @params  = params
    @action  = action
    @company = set_company
  end

  def run
    return company, self.send(action)
  end

  private
    attr_reader :company
    def set_company
      begin
        if not params[:company_id].blank?
          @company = Company.find( params[:company_id] )
        elsif not params[:company_email].blank?
          @company = Company.find_by( email: params[:company_email] )
        else
          @company   = nil
        end
      rescue ActiveRecord::RecordNotFound
        @company   = nil
      end
    end

    def cancel
      {company_id: nil}
    end

    def signup
      return {}                if company.blank?
      {company_id: company.id}
    end

end
