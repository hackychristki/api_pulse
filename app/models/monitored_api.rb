class MonitoredApi < ApplicationRecord
  has_many :api_checks, dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true
  validates :expected_status,
            presence: true,
            numericality: { only_integer: true, in: 100..599 }
end