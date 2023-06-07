class User < ApplicationRecord
  has_one :experient_user, dependent: :destroy
  has_one :experiment, through: :experient_user

  validates :device_token, presence: true, uniqueness: true
end
