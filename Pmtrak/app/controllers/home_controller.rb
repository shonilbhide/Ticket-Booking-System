class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    session[:admin_id] = nil
    session[:passenger_id] = nil
  end
end
