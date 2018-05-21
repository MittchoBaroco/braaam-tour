class CompaniesController < ApplicationController
  before_action :authenticate_company!

  def bookings
    @bookings = current_company.tours.uniq
  end

  def settings
  end

  # PATCH/PUT /admin/companies/1
  # PATCH/PUT /admin/companies/1.json
  def update
    @company = current_company

    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to company_settings_path(@company), notice: 'Company was successfully created.' }
        format.json { render :show, status: :ok, location: company_path(@company) }
      else
        format.html { render :settings }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.fetch(:company, {}).permit(
      :email, :name, :company_address_line1,
      :company_address_line2, :company_country,
      :company_npa, :company_city,
      :reference_person_full_name
    )
  end
end
