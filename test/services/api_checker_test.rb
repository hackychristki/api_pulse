require "test_helper"

class ApiCheckerTest < ActiveSupport::TestCase
  setup do
    @monitored_api = monitored_apis(:one)
  end

  test "stores a successful API check" do
    response = Struct.new(:code).new("200")
    checker = checker_returning(response)

    assert_difference("@monitored_api.api_checks.count", 1) do
      @result = checker.call
    end

    assert_predicate @result, :online?
    assert_equal 200, @result.http_status
    assert_nil @result.error_message
    assert_operator @result.response_time_ms, :>=, 0
  end

  test "stores an unexpected status as offline" do
    response = Struct.new(:code).new("500")
    checker = checker_returning(response)

    @result = checker.call

    assert_not @result.online?
    assert_equal 500, @result.http_status
    assert_equal "Expected HTTP 200, received 500", @result.error_message
  end

  test "stores connection errors without an HTTP status" do
    checker_class = Class.new(ApiChecker) do
      private

      def perform_request
        raise SocketError, "DNS failure"
      end
    end
    @result = checker_class.new(@monitored_api).call

    assert_not @result.online?
    assert_nil @result.http_status
    assert_match(/SocketError: DNS failure/, @result.error_message)
  end

  private

  def checker_returning(response)
    checker_class = Class.new(ApiChecker) do
      define_method(:initialize) do |monitored_api|
        super(monitored_api)
        @fake_response = response
      end

      private

      attr_reader :fake_response

      def perform_request
        fake_response
      end
    end

    checker_class.new(@monitored_api)
  end
end
