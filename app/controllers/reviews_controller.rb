class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
    @booking = @review.booking
    @vehicle = @booking.vehicle
  end

  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    @review.user = current_user
    @vehicle = @booking.vehicle
    if @review.save
      redirect_to vehicle_booking_review_path(@vehicle, @booking, @review), notice: 'Review was successfully created.'
    else
      @vehicle = @booking.vehicle
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @booking = @review.booking
    @vehicle = @booking.vehicle
  end

  def update
    @review = Review.find(params[:id])
    @vehicle = Vehicle.find(params[:vehicle_id])
    @booking = Booking.find(params[:booking_id])
    if @review.update(review_params)
      redirect_to vehicle_booking_review_path(@vehicle, @booking, @review), notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @booking = @review.booking
    @vehicle = @booking.vehicle
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
