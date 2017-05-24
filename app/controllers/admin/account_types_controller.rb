class Admin::AccountTypesController < ApplicationController
  before_action :set_admin_account_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/account_types
  # GET /admin/account_types.json
  def index
    @admin_account_types = AccountType.all
  end

  # GET /admin/account_types/1
  # GET /admin/account_types/1.json
  def show
  end

  # GET /admin/account_types/new
  def new
    @admin_account_type = AccountType.new
  end

  # GET /admin/account_types/1/edit
  def edit
    @admin_account_type = AccountType.find(params[:id])
  end

  # POST /admin/account_types
  # POST /admin/account_types.json
  def create
    @admin_account_type = AccountType.new(admin_account_type_params)

    respond_to do |format|
      if @admin_account_type.save
        format.html { redirect_to admin_account_types_url, notice: 'Account type was successfully created.' }
        format.json { render :show, status: :created, location: @admin_account_type }
      else
        format.html { render :new }
        format.json { render json: @admin_account_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/account_types/1
  # PATCH/PUT /admin/account_types/1.json
  def update
    respond_to do |format|
      if @admin_account_type.update(admin_account_type_params)
        format.html { redirect_to admin_account_types_url, notice: 'Account type was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_account_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_account_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/account_types/1
  # DELETE /admin/account_types/1.json
  def destroy
    @admin_account_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_account_types_url, notice: 'Account type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_account_type
      @admin_account_type = AccountType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_account_type_params
      params.require(:admin_account_type).permit(:name, :space, :price)
    end
end
