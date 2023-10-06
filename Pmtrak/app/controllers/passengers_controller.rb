class PassengersController < ApplicationController
  before_action :set_passenger, only: %i[ show edit update destroy ]
  skip_before_action :authorized, only: [:new, :create]
  before_action :authorized_passenger, except: [:new, :create, :edit, :update, :destroy]
  # GET /passengers or /passengers.json
  def index
    @passengers = Passenger.all
    @trains = Train.all
  end

  def my_trips
    @passenger = Passenger.find(params[:id])
    if (@passenger != current_user)
      redirect_to my_trips_passenger_path(current_user)
    end
    @booked_trains = @passenger.tickets.includes(:train).map(&:train)
    @reviews = Review.where(passenger: @passenger)
  end

  def user_reviews
    @passenger = Passenger.find(params[:id])
    if (@passenger != current_user)
      redirect_to user_reviews_passenger_path(current_user)
    end
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
        if session[:admin_id]
            @admin = Admin.first
            format.html { redirect_to show_passengers_admin_path(@admin), notice: "Passenger was successfully created." }
          else
          format.html { redirect_to passenger_url(@passenger), notice: "Passenger was successfully created." }
          format.json { render :show, status: :created, location: @passenger }
        end
      else
        @admin = Admin.first
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /passengers/1 or /passengers/1.json
  def update
    respond_to do |format|
      if @passenger.update(passenger_params)
        if session[:admin_id]
          @admin = Admin.first
          format.html { redirect_to show_passengers_admin_path(@admin), notice: "Passenger was successfully updated." }
        else
        format.html { redirect_to passenger_url(@passenger), notice: "Passenger was successfully updated." }
        format.json { render :show, status: :ok, location: @passenger }
        end
      else
        @admin = Admin.first
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passengers/1 or /passengers/1.json
  def destroy
    @passenger.destroy
    session[:passenger_id] = nil
    if is_admin?
      respond_to do |format|
        format.html { redirect_to show_passengers_admin_url(@current_user), notice: "Passenger was successfully destroyed." }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_url, notice: "Passenger was successfully destroyed." }
        format.json { head :no_content }
      end
    end 
  end

  def show
    @trains = Train.all
  end

  def show_trains
    @passenger = set_passenger
    query_string = 'seats_left>0 AND departure_date > ?',DateTime.now
    @trains = Train.where(query_string)

    if params[:search_by_rating].present?
      min_rating = params[:search_by_rating].to_f
      @trains = @trains.joins(:reviews)
                      .group("trains.id")
                      .having("AVG(reviews.rating) >= ?", min_rating)
    else
      if params[:search_by_departure].present?
        @trains = @trains.where(query_string).where('departure_station = ?',params[:search_by_departure])
      end
      if params[:search_by_arrival].present?
        @trains = @trains.where(query_string).where('termination_station = ?',params[:search_by_arrival])
      end
    end
  end

  def show_reviews
    @passenger = set_passenger
    @booked_trains = @passenger.tickets.includes(:train).map(&:train)
    @my_reviews = @passenger.reviews
    if params[:search_by_user_name].present?
      user = Passenger.find_by(name: params[:search_by_user_name])
      @reviews = user&.reviews || []
    elsif params[:search_by_train_number].present?
      train = Train.find_by(train_number: params[:search_by_train_number])
      @reviews = train&.reviews || []
    else
      @reviews = @my_reviews
    end
  end

  def display
    @passenger = set_passenger
  end

  def login
    
  end

  def show_booked_tickets
    @my_tickets = Ticket.where(passenger_id: current_user.id)
    @other_tickets = Ticket.where("creator_id = ? AND passenger_id != ?", current_user.id, current_user.id)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
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
