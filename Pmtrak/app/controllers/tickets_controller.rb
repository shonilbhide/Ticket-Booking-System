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
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
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
    # Assuming you have set up @train and current_user
    existing_ticket = Ticket.find_by(passenger: current_user, train: @train)

    if existing_ticket
      # Redirect with a message saying the user has already booked this train
      redirect_to passenger_path(current_user), alert: 'You have already booked this train!'
    elsif @train.seats_left > 0
      Ticket.create(passenger: current_user, train: @train)
      @train.update(seats_left: @train.seats_left - 1)
      redirect_to passenger_path(current_user), notice: 'Train booked successfully!'
    else
      # Redirect with a message saying no seats are left
      redirect_to some_path, alert: 'No seats left on this train!'
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
