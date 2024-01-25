require "faker"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Generate Test User
test_user = User.new
test_user.email = "test@me.com"
test_user.password = "secret"
test_user.save!

# email: test@me.com
# password: secret

instance_count = 20

# Generate Users
instance_count.times do |index|
  user = User.new
  user.email = "#{Faker::Name.first_name}@example.com"
  user.password = "secret"
  user.save!
end

intros = ["You will love this", "You'll have a wonderful time camping in this", "Enjoy the great outdoors in this", "Lose yourself in this"]
vehicles = ["caravan", "camper", "RV", "SUV", "wagon"]

# Generate Vehicles
instance_count.times do |index|
  user = User.all.sample
  vehicle = vehicles.sample
  adjective = Faker::Adjective.positive
  title = "#{adjective} #{vehicle}"
  description = "#{intros.sample} #{adjective} #{vehicle}"
  price = Random.rand(7..20) * 1000
  days = Random.rand(0..127)
  new_vehicle = Vehicle.new(user: user, title: title, description: description, price: price, days: days)
  p [title, description, price, days]
  new_vehicle.save!
  puts "Saved! #{index + 1} of #{instance_count}"
end

# Generate Bookings
instance_count.times do |index|
  user = User.all.sample
  vehicle = Vehicle.all.sample

  start_date = Faker::Date.forward(days: 23)
  end_date = start_date + Random.rand(1..5).days

  status = Random.rand(0..3)

  # Create a new Booking
  booking = Booking.new(
    user: user,
    vehicle: vehicle,
    start_date: start_date,
    end_date: end_date,
    status: status,
  )
  p [user, vehicle, start_date, end_date, status]
  booking.save!
  puts "Saved Booking! #{index + 1} of #{instance_count}"
end

instance_count.times do |index|
  booking = Booking.all.sample
  user = booking.user

  # Debugging statements
  puts "Generating review #{index + 1}: Booking ID: #{booking.id}, User ID: #{user.id}"

  rating = Random.rand(1..5)
  content = Faker::Lorem.sentence(word_count: 10)

  # Create a new Review
  review = Review.new(
    booking: booking,
    user_id: user.id,
    rating: rating,
    content: content,
  )
  p [booking, user, rating, content]

  review.save!
end
