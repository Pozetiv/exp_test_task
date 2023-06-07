class ExperientUser < ApplicationRecord
  belongs_to :user
  belongs_to :experiment, counter_cache: true

  validates :current_value, presence: true
  validates :user_id, uniqueness: true
end
