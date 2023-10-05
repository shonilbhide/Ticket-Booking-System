class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  before_action :set_train, only: [:book]

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to show_tickets_admin_path(@current_user), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @train = @ticket.train
    @ticket.destroy
    @train.update(seats_left: @train.seats_left + 1)
    if is_admin?
      respond_to do |format|
        format.html { redirect_to show_tickets_admin_url(@current_user), notice: "Review was successfully destroyed." }
      end
    else
    respond_to do |format|
      format.html { redirect_to my_trips_passenger_path(current_user), notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  end

  def book
    @train = set_train
    existing_ticket = Ticket.find_by(passenger: current_user, train: @train)
  end

  def admin_access
    @admin = Admin.first
    if params[:search_passenger_email].present? and params[:search_train_number].present?
      selected_passenger = Passenger.find_by_email(params[:search_passenger_email])
      selected_train = Train.find_by(train_number: params[:search_train_number])
    if selected_passenger and selected_train
     if selected_train.seats_left > 0
      Ticket.create(passenger: selected_passenger,train: selected_train,creator_id: selected_passenger.id)
      selected_train.update(seats_left: selected_train.seats_left - 1)
      redirect_to show_tickets_admin_path(@admin), notice: 'Ticket Created!'
     else
      redirect_to show_tickets_admin_path(@admin), notice: 'Train Capacity full!'
     end
    else
      redirect_to show_tickets_admin_path(@admin), notice: 'Either passenger or train does not exist!'
    end
    end
  end


  def book_now
    @train = set_train
   
    if params[:Add_passenger].present?
      current_passenger = Passenger.find_by_email(params[:Add_passenger])
    else
      current_passenger = current_user
    end
    # Assuming you have set up @train and current_user
    existing_ticket = Ticket.find_by(passenger: current_passenger, train: @train)
    if current_passenger
      if existing_ticket
        # Redirect with a message saying the user has already booked this train
        redirect_to passenger_path(current_user), notice: 'You have already booked this train!'
      elsif @train.seats_left > 0
        Ticket.create(passenger: current_passenger,train: @train,creator_id: current_user.id )
        @train.update(seats_left: @train.seats_left - 1)
        redirect_to passenger_path(current_passenger), notice: 'Train booked successfully!'
      else
        # Redirect with a message saying no seats are left
        redirect_to show_trains_passenger_path(current_user), notice: 'No seats left on this train!'
      end
    else
      redirect_to show_trains_passenger_path(current_user), notice: 'Passenger does not exist!'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def set_train
      @train = Train.find(params[:train_id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:confirmation_number)
    end
end
