require "net/http"
require "uri"

class ApiChecker
  OPEN_TIMEOUT = 5
  READ_TIMEOUT = 10

  def initialize(monitored_api)
    @monitored_api = monitored_api
  end

  def call
    started_at = monotonic_time
    response = perform_request
    response_time_ms = elapsed_ms_since(started_at)
    status = response.code.to_i
    online = status == @monitored_api.expected_status

    @monitored_api.api_checks.create!(
      http_status: status,
      response_time_ms: response_time_ms,
      checked_at: Time.current,
      online: online,
      error_message: error_message_for(status, online)
    )
  rescue StandardError => error
    @monitored_api.api_checks.create!(
      response_time_ms: elapsed_ms_since(started_at),
      checked_at: Time.current,
      online: false,
      error_message: "#{error.class}: #{error.message}"
    )
  end

  private

  def perform_request
    uri = URI.parse(@monitored_api.url)

    unless uri.is_a?(URI::HTTP) && uri.host.present?
      raise ArgumentError, "Only valid HTTP and HTTPS URLs are supported"
    end

    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "API Pulse/1.0"

    Net::HTTP.start(
      uri.host,
      uri.port,
      use_ssl: uri.scheme == "https",
      open_timeout: OPEN_TIMEOUT,
      read_timeout: READ_TIMEOUT
    ) do |http|
      http.request(request)
    end
  end

  def error_message_for(status, online)
    return if online

    "Expected HTTP #{@monitored_api.expected_status}, received #{status}"
  end

  def monotonic_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  def elapsed_ms_since(started_at)
    ((monotonic_time - started_at) * 1_000).round
  end
end