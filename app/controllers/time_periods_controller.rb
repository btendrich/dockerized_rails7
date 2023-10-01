class TimePeriodsController < ApplicationController
  before_action :set_time_period, only: %i[ show edit update destroy ]

  # GET /time_periods or /time_periods.json
  def index
    @pagy, @time_periods = pagy(TimePeriod.order(sort_sql), items: 25)
  end

  # GET /time_periods/new
  def new
    @time_period = TimePeriod.new
  end

  # GET /time_periods/1/edit
  def edit
  end

  # POST /time_periods or /time_periods.json
  def create
    @time_period = TimePeriod.new(time_period_params)

    if @time_period.save
      redirect_to time_period_url(@time_period), notice: "Time period was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /time_periods/1 or /time_periods/1.json
  def update
    if @time_period.update(time_period_params)
      redirect_to time_period_url(@time_period), notice: "Time period was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /time_periods/1 or /time_periods/1.json
  def destroy
    @time_period.destroy

    redirect_to time_periods_url, notice: "Time period was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_period
      @time_period = TimePeriod.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def time_period_params
      params.require(:time_period).permit(:name, :begins, :ends, :description)
    end
end
