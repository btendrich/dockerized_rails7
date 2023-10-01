class RateClassificationsController < ApplicationController
  before_action :set_rate_classification, only: %i[ show edit update destroy ]

  # GET /rate_classifications or /rate_classifications.json
  def index
    @pagy, @rate_classifications = pagy(RateClassification.order(sort_sql), items: 25)
  end

  # GET /rate_classifications/new
  def new
    @rate_classification = RateClassification.new
  end

  # GET /rate_classifications/1/edit
  def edit
  end

  # POST /rate_classifications or /rate_classifications.json
  def create
    @rate_classification = RateClassification.new(rate_classification_params)

    if @rate_classification.save
      redirect_to rate_classification_url(@rate_classification), notice: "Rate classification was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rate_classifications/1 or /rate_classifications/1.json
  def update
    if @rate_classification.update(rate_classification_params)
      redirect_to rate_classification_url(@rate_classification), notice: "Rate classification was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /rate_classifications/1 or /rate_classifications/1.json
  def destroy
    @rate_classification.destroy

    redirect_to rate_classifications_url, notice: "Rate classification was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate_classification
      @rate_classification = RateClassification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_classification_params
      params.require(:rate_classification).permit(:name)
    end
end
