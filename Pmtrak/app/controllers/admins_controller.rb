class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy ]
  before_action :authorized_admin
  skip_before_action :authorized, only: [:new, :create]

  # GET /admins or /admins.json
  def index
    @admin = set_admin
  end

  # GET /admins/1 or /admins/1.json
  def show
    @admin = set_admin
  end

  def display
    @admin = set_admin
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins or /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully created." }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1 or /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully updated." }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1 or /admins/1.json
  def destroy
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Admin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show_trains
    @admin = set_admin
    @trains = Train.all.order([:departure_station, termination_station: :desc])
    if params[:search_by_departure].present?
      @trains = @trains.where(departure_station: params[:search_by_departure])
    end
    if params[:search_by_termination].present?
      @trains = @trains.where(termination_station: params[:search_by_termination])
    end
  end

  def show_passengers
    @admin = set_admin
    @passengers = Passenger.all
  end

  def show_tickets
    @admin = set_admin
    @tickets = Ticket.all.includes(:passenger, :train).order(:train)
  end

  def show_reviews
    @admin = set_admin
    if params[:search_by_user_name].present?
      user = Passenger.find_by(name: params[:search_by_user_name])
      @reviews = user&.reviews || []
    elsif params[:search_by_train_number].present?
      train = Train.find_by(train_number: params[:search_by_train_number])
      @reviews = train&.reviews || []
    else
      @reviews = Review.all
    end
  end

  def show_train_customers
    @admin = set_admin
    if params[:search_train_customers].present?
      train = Train.find_by(train_number: params[:search_train_customers])
      if train && train.tickets
        @train_passengers = train.tickets.map {|ticket| Passenger.find_by_id(ticket.creator_id)}
      else
        @train_passengers = nil
      end
    end
  end

  def create_tickets
    @admin = set_admin
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      if current_user.is_a?(Admin)
        @admin = current_user
      else
        @admin = Admin.first
      end
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:username, :name, :email, :password_digest, :phone_number, :address, :credit_number)
    end
end
