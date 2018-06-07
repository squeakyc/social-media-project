class Tweet < ApplicationRecord

  # associations
  belongs_to :user

  # validations
  validates :message, presence: true
  validates :message, length: {maximum: 140,
  too_long: "too long. Max tweet 140 characters!"}
  # see form partial to customize further

end
