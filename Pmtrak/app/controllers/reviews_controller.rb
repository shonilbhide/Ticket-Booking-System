class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    if @review.passenger != current_user
      redirect_to my_trips_passenger_path(@passenger), alert: "You can only edit your own reviews."
    end
  end

  def create
    @passenger = current_user
    @train = Train.find(params[:train_id]) # You need to get the associated train from the params
    @review = @train.reviews.build(review_params.merge(passenger_id: current_user.id))

    respond_to do |format|
      if @review.save
        format.html { redirect_to my_trips_passenger_path(@passenger), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    @passenger = @review.passenger
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to my_trips_passenger_path(@passenger), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @passenger = current_user
    @review.destroy

    respond_to do |format|
      format.html { redirect_to my_trips_passenger_path(@passenger), notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:rating, :feedback, :passenger_id, :train_id)
  end
end
