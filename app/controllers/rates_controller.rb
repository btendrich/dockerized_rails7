class RatesController < ApplicationController
  before_action :set_rate, only: %i[ show edit update destroy ]

  # GET /rates or /rates.json
  def index
    @pagy, @rates = pagy(Rate.order(sort_sql).order(:name), items: 25)
  end

  # GET /rates/1 or /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates or /rates.json
  def create
    @rate = Rate.new(rate_params)

    if @rate.save
      redirect_to rate_url(@rate), notice: "Rate was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rates/1 or /rates/1.json
  def update
    if @rate.update(rate_params)
      redirect_to rate_url(@rate), notice: "Rate was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  # DELETE /rates/1 or /rates/1.json
  def destroy
    @rate.destroy

    redirect_to rates_url, notice: "Rate was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_params
      params.require(:rate).permit(:name, :short_code, :description, :uom, :rate_classification_id, :sort_order)
    end

    def sort_field
      "name"
    end

end
