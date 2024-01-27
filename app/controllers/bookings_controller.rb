class BookingsController < ApplicationController
  before_action :authenticate_user!,  only: [:index]

  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @booking = Booking.new
    @booking.user = current_user
  end

  def create
    @vehicle = Vehicle.find(params[:vehicle_id])
    @booking = Booking.new(booking_params)
    @booking.vehicle = @vehicle
    @booking.status = :pending
    @booking.user = current_user

    if @booking.save
      redirect_to @vehicle, notice: 'Booking was successfully created.'
    else
      Rails.logger.info(@booking.errors.full_messages)
      render :new, notice: 'Booking failed.'
    end
  end

  def index
    @my_bookings = current_user.bookings.order(start_date: :asc)  # or :desc for descending order
    # @my_bookings = @my_bookings.where('start_date >= ?', Date.today)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :vehicle_id) #add :user_id later
  end
end
