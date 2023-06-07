class Experiment < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :conditions, presence: true

  has_many :experient_user
end
