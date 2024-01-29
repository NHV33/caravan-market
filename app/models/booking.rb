class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  has_many :reviews

  validates :user, presence: true
  validates :vehicle, presence: true
  validates :status, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  enum status: [:pending, :approved, :declined, :cancelled]
end
