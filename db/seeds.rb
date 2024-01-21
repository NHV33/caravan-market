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

intros = ["You will love this", "You'll have a wonderful time camping in this", "Enjoy the great outdoors in this", "Lose your self in this"]
vehicles = ["caravan", "camper", "RV", "SUV", "wagon"]

instance_count = 20

# instance_count.times do |index|
#   user = User.new
#   user.email = "#{Faker::Name.first_name}@example.com"
#   user.password = '#$taawktljasktlw4aaglj'
#   user.save!
# end

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
