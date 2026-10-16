require "uri"

class MonitoredApi < ApplicationRecord
  has_many :api_checks, dependent: :destroy

  validates :name, presence: true
  validates :url,
            presence: true,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "muss eine gültige HTTP- oder HTTPS-URL sein" }
  validates :expected_status,
            presence: true,
            numericality: { only_integer: true, in: 100..599 }

  def latest_check
    return api_checks.max_by(&:checked_at) if api_checks.loaded?

    api_checks.order(checked_at: :desc).first
  end

  def average_response_time_ms
    if api_checks.loaded?
      response_times = api_checks.filter_map(&:response_time_ms)
      return if response_times.empty?

      return (response_times.sum.fdiv(response_times.size)).round
    end

    api_checks.where.not(response_time_ms: nil).average(:response_time_ms)&.round
  end
end
