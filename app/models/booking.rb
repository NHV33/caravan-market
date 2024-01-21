class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  validates :user, presence: true
  validates :vehicle, presence: true
  validates :status, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
