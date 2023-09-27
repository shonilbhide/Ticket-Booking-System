class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    @trains = Train.all
  end
end
