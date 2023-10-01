class ContributionRatesController < ApplicationController
  before_action :set_contribution_rate, only: %i[ show edit update destroy ]

  # GET /contribution_rates or /contribution_rates.json
  def index
    @contribution_rates = ContributionRate.all
  end

  # GET /contribution_rates/1 or /contribution_rates/1.json
  def show
  end

  # GET /contribution_rates/new
  def new
    @contribution_rate = ContributionRate.new
  end

  # GET /contribution_rates/1/edit
  def edit
  end

  # POST /contribution_rates or /contribution_rates.json
  def create
    @contribution_rate = ContributionRate.new(contribution_rate_params)

    respond_to do |format|
      if @contribution_rate.save
        format.html { redirect_to contribution_rate_url(@contribution_rate), notice: "Contribution rate was successfully created." }
        format.json { render :show, status: :created, location: @contribution_rate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contribution_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contribution_rates/1 or /contribution_rates/1.json
  def update
    respond_to do |format|
      if @contribution_rate.update(contribution_rate_params)
        format.html { redirect_to contribution_rate_url(@contribution_rate), notice: "Contribution rate was successfully updated." }
        format.json { render :show, status: :ok, location: @contribution_rate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contribution_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contribution_rates/1 or /contribution_rates/1.json
  def destroy
    @contribution_rate.destroy

    respond_to do |format|
      format.html { redirect_to contribution_rates_url, notice: "Contribution rate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution_rate
      @contribution_rate = ContributionRate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contribution_rate_params
      params.require(:contribution_rate).permit(:time_period_id, :rate_classification_id, :employee_classification_id, :name, :rate)
    end
end
