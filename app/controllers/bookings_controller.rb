class BookingsController < ApplicationController
  before_action :authenticate_user!,  only: [:index]

  def new
    @vehicle = Vehicle.find(params[:id])
    @booking = Booking.new
  end

  def create
    @vehicle = Vehicle.find(params[:booking][:vehicle_id])
    @booking = Booking.new(booking_params)
    @booking.vehicle = @vehicle

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def index
    @my_bookings = current_user.bookings
  end

  private
  def booking_params
    params.require(:booking).permit(:user, :vehicle, :status, :start_date, :end_date)
  end
end
