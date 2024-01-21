class Vehicle < ApplicationRecord
  belongs_to :user

  has_many :bookings
  has_many :provider_bookings
  has_many :reviews

  # validates :user, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :days, presence: true
end
