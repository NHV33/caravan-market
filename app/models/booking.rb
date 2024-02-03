class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  has_many :reviews

  validates :user, presence: true
  validates :vehicle, presence: true
  validates :status, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  enum status: { pending: 0, approved: 1, declined: 2,  cancelled: 3 }
end
