class Admin::CompaniesController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET admin/companies
  # GET admin/companies.json
  def index
    @companies = Company.all
  end

  # GET admin/companies/1
  # GET admin/companies/1.json
  def show
  end

  # GET admin/companies/new
  def new
    @company = Company.new
  end

  # GET admin/companies/1/edit
  def edit
  end

  # POST admin/companies
  # POST admin/companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to [:admin, @company], notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/companies/1
  # PATCH/PUT admin/companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to [:admin, @company], notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/companies/1
  # DELETE admin/companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to admin_companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:email, :name, :company_address_line1, :company_address_line2, :company_country, :company_npa, :company_city, :reference_person_full_name, :vat_number, :ape, :siret)
    end
end
