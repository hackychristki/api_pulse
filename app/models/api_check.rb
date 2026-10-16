class ApiCheck < ApplicationRecord
  belongs_to :monitored_api

  validates :checked_at, presence: true
  validates :online, inclusion: { in: [ true, false ] }
  validates :http_status, numericality: { only_integer: true, in: 100..599 }, allow_nil: true
  validates :response_time_ms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
