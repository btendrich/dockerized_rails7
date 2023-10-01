class PayrollItemsController < ApplicationController
  before_action :set_payroll_item, only: %i[ show edit update destroy ]

  # GET /payroll_items or /payroll_items.json
  def index
    if filter_payroll_id.empty?
      @pagy, @payroll_items = pagy(PayrollItem.all.order(sort_sql), items: 25)
    else
      @pagy, @payroll_items = pagy(PayrollItem.where(payroll_id: filter_payroll_id).order(sort_sql), items: 25)
    end
  end

  # GET /payroll_items/1 or /payroll_items/1.json
  def show
  end

  # GET /payroll_items/new
  def new
    @payroll_item = PayrollItem.new
  end

  # GET /payroll_items/1/edit
  def edit
  end

  # POST /payroll_items or /payroll_items.json
  def create
    @payroll_item = PayrollItem.new(payroll_item_params)

    respond_to do |format|
      if @payroll_item.save
        format.html { redirect_to payroll_item_url(@payroll_item), notice: "Payroll item was successfully created." }
        format.json { render :show, status: :created, location: @payroll_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payroll_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payroll_items/1 or /payroll_items/1.json
  def update
    respond_to do |format|
      if @payroll_item.update(payroll_item_params)
        format.html { redirect_to payroll_item_url(@payroll_item), notice: "Payroll item was successfully updated." }
        format.json { render :show, status: :ok, location: @payroll_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payroll_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payroll_items/1 or /payroll_items/1.json
  def destroy
    @payroll_item.destroy

    respond_to do |format|
      format.html { redirect_to payroll_items_url, notice: "Payroll item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payroll_item
      @payroll_item = PayrollItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payroll_item_params
      params.require(:payroll_item).permit(:source_hour_id, :payroll_id, :employee_id, :source_rate_id, :source_rate_amount_id, :amount, :quantity, :correction, :notes)
    end
    
    def filter_payroll_id
      params.permit(:payroll_id).fetch(:payroll_id,'')
    end
    
end
