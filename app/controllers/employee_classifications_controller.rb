class EmployeeClassificationsController < ApplicationController
  before_action :set_employee_classification, only: %i[ show edit update destroy ]

  # GET /employee_classifications or /employee_classifications.json
  def index
    @pagy, @employee_classifications = pagy(EmployeeClassification.order(sort_sql), items: 25)
  end

  # GET /employee_classifications/new
  def new
    @employee_classification = EmployeeClassification.new
  end

  # GET /employee_classifications/1/edit
  def edit
  end

  # POST /employee_classifications or /employee_classifications.json
  def create
    @employee_classification = EmployeeClassification.new(employee_classification_params)

    if @employee_classification.save
      redirect_to employee_classification_url(@employee_classification), notice: "Employee classification was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employee_classifications/1 or /employee_classifications/1.json
  def update
    if @employee_classification.update(employee_classification_params)
      redirect_to employee_classification_url(@employee_classification), notice: "Employee classification was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /employee_classifications/1 or /employee_classifications/1.json
  def destroy
    @employee_classification.destroy

    redirect_to employee_classifications_url, notice: "Employee classification was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_classification
      @employee_classification = EmployeeClassification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_classification_params
      params.require(:employee_classification).permit(:name)
    end
end
