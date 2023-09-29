class PassengersController < ApplicationController
  before_action :set_passenger, only: %i[ show edit update destroy ]
  skip_before_action :authorized, only: [:new, :create]
  # GET /passengers or /passengers.json
  def index
    @passengers = Passenger.all
    @trains = Train.all
  end

  def my_trips
    @passenger = Passenger.find(params[:id])
    @booked_trains = @passenger.tickets.includes(:train).map(&:train)
    @reviews = Review.where(passenger: @passenger)
  end

  def user_reviews
    @passenger = Passenger.find(params[:id])
    @reviews = @passenger.reviews
  end


  # GET /passengers/new
  def new
    @admin = Admin.first
    @passenger = Passenger.new
  end

  # GET /passengers/1/edit
  def edit
  end

  # POST /passengers or /passengers.json
  def create
    @passenger = Passenger.new(passenger_params)

    respond_to do |format|
      if @passenger.save
        format.html { redirect_to passenger_url(@passenger), notice: "Passenger was successfully created." }
        format.json { render :show, status: :created, location: @passenger }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /passengers/1 or /passengers/1.json
  def update
    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to passenger_url(@passenger), notice: "Passenger was successfully updated." }
        format.json { render :show, status: :ok, location: @passenger }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passengers/1 or /passengers/1.json
  def destroy
    @passenger.destroy
    session[:passenger_id] = nil
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Passenger was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def show
  #   @booked_trains = @passenger.tickets.includes(:train).map(&:train)
  #   @trains = Train.all
  #   @reviews_by_user = Review.where(passenger: @passenger)
  #   @reviews_for_trains = @booked_trains.map { |train| {train: train, reviews: train.reviews} }
  # end
  def show
    @trains = Train.all
  end

  def show_trains
    @passenger = set_passenger

    if params[:search_by_departure].present?
      @trains = Train.where(departure_station: params[:search_by_departure])
      puts @trains
    elsif params[:search_by_arrival].present?
      @trains = Train.where(termination_station: params[:search_by_arrival])
    else
      @trains = Train.where('departure_date > ?', DateTime.now)
    end
  end

  def show_reviews
    @passenger = set_passenger
    @booked_trains = @passenger.tickets.includes(:train).map(&:train)

    if params[:search_by_user_name].present?
      user = Passenger.find_by(name: params[:search_by_user_name])
      @reviews = user&.reviews || []
    elsif params[:search_by_train_number].present?
      train = Train.find_by(train_number: params[:search_by_train_number])
      @reviews = train&.reviews || []
    else
      @reviews = @booked_trains.map { |train| {train: train, reviews: train.reviews} }
    end
  end

  def display
    @passenger = set_passenger
  end

  def login
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_passenger
    #   @passenger = Passenger.find(params[:id])
    # end

  def set_passenger
    if current_user.is_a?(Passenger)
      @passenger = current_user
    else
      @passenger = Passenger.find(params[:id])
    end
  end

  # Only allow a list of trusted parameters through.
    def passenger_params
      params.require(:passenger).permit(:name, :email, :password, :phone_number, :address, :credit_number)
    end
end
