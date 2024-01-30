class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  has_one :vehicle, through: :booking

  validates :booking, presence: true
  validates :rating, presence: true
  validates :content, presence: true
end
