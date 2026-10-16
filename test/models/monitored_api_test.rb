require "test_helper"

class MonitoredApiTest < ActiveSupport::TestCase
  test "requires a valid HTTP or HTTPS URL" do
    monitored_api = MonitoredApi.new(name: "Invalid", url: "not-a-url", expected_status: 200)

    assert_not monitored_api.valid?
    assert_includes monitored_api.errors[:url], "muss eine gültige HTTP- oder HTTPS-URL sein"
  end

  test "requires an HTTP status between 100 and 599" do
    monitored_api = monitored_apis(:one)

    monitored_api.expected_status = 99
    assert_not monitored_api.valid?

    monitored_api.expected_status = 600
    assert_not monitored_api.valid?
  end

  test "returns the latest check" do
    monitored_api = monitored_apis(:one)
    latest = monitored_api.api_checks.create!(
      http_status: 200,
      response_time_ms: 300,
      checked_at: 1.minute.from_now,
      online: true
    )

    assert_equal latest, monitored_api.latest_check
  end

  test "calculates the average response time" do
    monitored_api = monitored_apis(:one)
    monitored_api.api_checks.create!(
      http_status: 200,
      response_time_ms: 240,
      checked_at: Time.current,
      online: true
    )

    assert_equal 180, monitored_api.average_response_time_ms
  end
end
