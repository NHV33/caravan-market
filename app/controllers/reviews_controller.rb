class ReviewsController < ApplicationController
  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    @review.user = current_user  # Set the user for the review

    if @review.save
      redirect_to root_path, notice: 'Review was successfully created.'
    else
      @vehicle = @booking.vehicle
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end

