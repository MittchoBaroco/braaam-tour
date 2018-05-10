class CompaniesController < ApplicationController
  before_action :authenticate_company!

  def bookings
    @bookings = current_company.tours
  end

  def settings
  end
end
