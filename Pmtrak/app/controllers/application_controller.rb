class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :authorized
    helper_method :logged_in?
    helper_method :is_admin?
    helper_method :authorized_admin
    helper_method :is_passenger?
    helper_method :authorized_passenger


    def current_user
      begin
        if session[:passenger_id]
          @current_user ||= Passenger.find(session[:passenger_id])
        elsif session[:admin_id]
          @current_user ||= Admin.find(session[:admin_id])
        else
          @current_user = nil
        end
      rescue ActiveRecord::RecordNotFound
        session.clear
        @current_user = nil
      end
    end

  
    def logged_in?
      !current_user.nil?
    end

    def is_admin?
      @current_user.class == Admin
    end

    def is_passenger?
      @current_user.class == Passenger
    end
   
    def authorized
      redirect_to root_path unless logged_in?
    end

    # def authorized_admin
    #   if !logged_in? || !is_admin?
    #     if !is_passenger?
    #       redirect_to passenger_path(@current_user), alert: "Invalid Action"
    #     else
    #       redirect_to logout_path, alert: "Invalid Action"
    #     end
    #   end
    # end
    def authorized_admin
      if !logged_in? || !is_admin?
        if @current_user && is_passenger?
          redirect_to passenger_path(@current_user), alert: "Invalid Action"
        else
          redirect_to logout_path, alert: "Invalid Action"
        end
      end
    end



    def authorized_passenger
      if !logged_in? || !is_passenger?
        if !is_admin?
          redirect_to admin_path(@current_user), alert: "Invalid Action"
        else
          redirect_to logout_path, alert: "Invalid Action"
        end
      end
    end
   
  end
  