class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def new
  end

  def create
    user = Admin.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:admin_id] = user.id
      redirect_to admin_path
    elsif
      user = Passenger.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:passenger_id] = user.id
        redirect_to passengers_path
      else
        flash.now[:alert] = "Email or password is invalid"
        render "new"
      end
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
