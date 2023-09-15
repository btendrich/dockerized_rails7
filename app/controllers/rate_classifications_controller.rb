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

    respond_to do |format|
      if @rate_classification.save
        format.html { redirect_to rate_classification_url(@rate_classification), notice: "Rate classification was successfully created." }
        format.json { render :show, status: :created, location: @rate_classification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rate_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rate_classifications/1 or /rate_classifications/1.json
  def update
    respond_to do |format|
      if @rate_classification.update(rate_classification_params)
        format.html { redirect_to rate_classification_url(@rate_classification), notice: "Rate classification was successfully updated." }
        format.json { render :show, status: :ok, location: @rate_classification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rate_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_classifications/1 or /rate_classifications/1.json
  def destroy
    @rate_classification.destroy

    respond_to do |format|
      format.html { redirect_to rate_classifications_url, notice: "Rate classification was successfully destroyed." }
      format.json { head :no_content }
    end
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
