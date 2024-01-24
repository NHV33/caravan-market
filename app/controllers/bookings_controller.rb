class BookingsController < ApplicationController
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

  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status, :user_id, :vehicle_id)
  end
end
