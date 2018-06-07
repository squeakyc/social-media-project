class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # associations
  has_many :tweets

  # validations
  validates :username, presence: true, uniqueness: true

  # avatar uploader (mount_uploader is a method that carrierwave brings into the app)
  mount_uploader :avatar, AvatarUploader

  serialize :following, Array
end
