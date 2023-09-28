class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    admin = Admin.find_by_email(params[:email])
    passenger = Passenger.find_by_email(params[:email])

    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_path(admin), notice: "Admin logged in successfully."
    elsif passenger && passenger.authenticate(params[:password])
      session[:passenger_id] = passenger.id
      redirect_to passenger_path(passenger), notice: "Passenger logged in successfully."
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:admin_id] = nil
    session[:passenger_id] = nil
    redirect_to root_url
  end
end
