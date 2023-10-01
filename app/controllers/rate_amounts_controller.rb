class RateAmountsController < ApplicationController
  before_action :set_rate_amount, only: %i[ show edit update destroy ]

  # GET /rate_amounts or /rate_amounts.json
  def index
    @pagy, @rate_amounts = pagy(RateAmount.order(sort_sql), items: 25)
  end

  # GET /rate_amounts/new
  def new
    @rate_amount = RateAmount.new
  end

  # GET /rate_amounts/1/edit
  def edit
  end

  # POST /rate_amounts or /rate_amounts.json
  def create
    @rate_amount = RateAmount.new(rate_amount_params)

    if @rate_amount.save
      redirect_to rate_amount_url(@rate_amount), notice: "Rate amount was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rate_amounts/1 or /rate_amounts/1.json
  def update
    if @rate_amount.update(rate_amount_params)
      redirect_to rate_amount_url(@rate_amount), notice: "Rate amount was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /rate_amounts/1 or /rate_amounts/1.json
  def destroy
    @rate_amount.destroy

    redirect_to rate_amounts_url, notice: "Rate amount was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate_amount
      @rate_amount = RateAmount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_amount_params
      params.require(:rate_amount).permit(:rate_id, :time_period_id, :amount)
    end
end
