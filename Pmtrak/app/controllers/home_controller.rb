class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    if (current_user.class == Admin)
      respond_to do |format|
        format.html { redirect_to admin_path(current_user), notice: "Admin page" }
      end
      
    elsif (current_user.class == Passenger)
      respond_to do |format|
        format.html { redirect_to passenger_path(current_user), notice: "Admin page" }
      end
    else
      session[:admin_id] = nil
      session[:passenger_id] = nil
    end
  end
end
