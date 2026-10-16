require "test_helper"

class ApiCheckTest < ActiveSupport::TestCase
  test "allows a missing HTTP status for connection errors" do
    api_check = ApiCheck.new(
      monitored_api: monitored_apis(:one),
      checked_at: Time.current,
      online: false,
      error_message: "SocketError: DNS failure"
    )

    assert api_check.valid?
  end

  test "rejects invalid response times" do
    api_check = api_checks(:one)
    api_check.response_time_ms = -1

    assert_not api_check.valid?
  end
end
