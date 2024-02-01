class VehiclesController < ApplicationController

  def int_to_days_hash(num)
    dotw = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
    bin = num.to_i.to_s(2).rjust(7, "0")
    days = {}
    bin.chars.each_with_index do | digit, index |
      days[dotw[index]] = (digit == "1")
    end
    return days
  end

  def days_list_to_int(days_list)
    return 0 unless (days_list.kind_of?(Array) && days_list.length >= 1 && days_list.length <= 7)
    dotw = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
    bin = ""
    dotw.each do |day|
      days_list.include?(day) ? bin += "1" : bin += "0"
    end
    return bin.to_i(2)
  end

  # before_action :

  def index
    vehicles = Vehicle.all
    @listings = []
    vehicles.each do |vehicle|
      days_hash = int_to_days_hash(vehicle.days)
      @listings << { vehicle: vehicle, days: days_hash }
    end
    @listings.reverse!
  end

  def search
    @query = params[:query]
    vehicles = Vehicle.all
    @listings = []
    vehicles.each do |vehicle|
      days_hash = int_to_days_hash(vehicle.days)
      if vehicle.title.downcase.include?(@query) || vehicle.description.downcase.include?(@query)
        @listings << { vehicle: vehicle, days: days_hash }
      end
    end
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @vehicle_reviews = @vehicle.reviews
    @listing = { vehicle: @vehicle, days: int_to_days_hash(@vehicle.days) }
  end

  
  def create
    @vehicle = current_user.vehicles.build(vehicle_params)
    @vehicle.days = days_list_to_int(params[:vehicle][:days])
    if @vehicle.save
     redirect_to @vehicle
    else
      render :new, status: 422
    end
  end

  def new
    @vehicle = Vehicle.new
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    @vehicle.days = days_list_to_int(params[:vehicle][:days])
    if @vehicle.update(vehicle_params)
     redirect_to @vehicle, notice: "Information updated!"
    else
      render :edit
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:user, :title, :description, :price)
  end

end
