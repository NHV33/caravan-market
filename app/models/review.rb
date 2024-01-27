class Review < ApplicationRecord
  belongs_to :booking
  has_one :user, through: :booking
  has_one :vehicle, through: :booking

  validates :booking, presence: true
  validates :rating, presence: true
  validates :content, presence: true
end
