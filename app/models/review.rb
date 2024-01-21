class Review < ApplicationRecord
  belongs_to :vehicle
  belongs_to :user

  validates :vehicle, presence: true
  validates :user, presence: true
  validates :rating, presence: true
  validates :content, presence: true
end
