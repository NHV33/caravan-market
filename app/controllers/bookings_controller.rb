class BookingsController < ApplicationController
  before_action :authenticate_user!,  only: [:index]

  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @booking = Booking.new
    @booking.user = current_user
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @vehicle_price = @vehicle.price

    if @start_date.present? && @end_date.present?
      start_date = Date.parse(@start_date)
      end_date = Date.parse(@end_date)
      total_days = (end_date - start_date).to_i + 1
      @total_price = @vehicle_price * total_days
    else
      @total_price = 0
    end

    Rails.logger.info "Vehicle price: #{@vehicle_price}"
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
    @provider_bookings = current_user.provider_bookings
  end

  def update
    @provider_booking = current_user.provider_bookings.find(params[:id])
    if @provider_booking.update(booking_params)
      redirect_to bookings_path, notice: 'Booking is successfully updated'
    else
      redirect_to bookings_path, alert: 'Booking status update is failed'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :vehicle_id, :status) #add :user_id later
  end
end
