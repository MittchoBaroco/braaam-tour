class Admin::ManagersController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_manager, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET admin/managers
  # GET admin/managers.json
  def index
    @managers = Manager.all
  end

  # GET admin/managers/1
  # GET admin/managers/1.json
  def show
  end

  # GET admin/managers/new
  def new
    @manager = Manager.new
  end

  # GET admin/managers/1/edit
  def edit
  end

  # POST admin/managers
  # POST admin/managers.json
  def create
    @manager = Manager.new(manager_params)

    respond_to do |format|
      if @manager.save
        format.html { redirect_to [:admin, @manager], notice: 'Manager was successfully created.' }
        format.json { render :show, status: :created, location: @manager }
      else
        format.html { render :new }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/managers/1
  # PATCH/PUT admin/managers/1.json
  def update
    respond_to do |format|
      if @manager.update_with_password(manager_params)
        format.html { redirect_to [:admin, @manager], notice: 'Manager was successfully updated.' }
        format.json { render :show, status: :ok, location: @manager }
      else
        format.html { render :edit }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/managers/1
  # DELETE admin/managers/1.json
  def destroy
    @manager.destroy
    respond_to do |format|
      format.html { redirect_to admin_managers_url, notice: 'Manager was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager
      @manager = Manager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manager_params
      params.require(:manager).permit(:email, :full_name, :current_password, :password, :password_confirmation)
    end
end
