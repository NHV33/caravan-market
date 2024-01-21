class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vehicles
  has_many :bookings
  has_many :provider_bookings, through: :vehicles, source: :bookings
  has_many :reviews
end
