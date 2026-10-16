require "test_helper"

class MonitoredApisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monitored_api = monitored_apis(:one)
  end

  test "should get index" do
    get monitored_apis_url
    assert_response :success
  end

  test "should get new" do
    get new_monitored_api_url
    assert_response :success
  end

  test "should create monitored_api" do
    assert_difference("MonitoredApi.count") do
      post monitored_apis_url, params: { monitored_api: { expected_status: @monitored_api.expected_status, name: @monitored_api.name, url: @monitored_api.url } }
    end

    assert_redirected_to monitored_api_url(MonitoredApi.last)
  end

  test "should show monitored_api" do
    get monitored_api_url(@monitored_api)
    assert_response :success
  end

  test "should check monitored_api" do
    @monitored_api.update!(url: "http://127.0.0.1:1")

    assert_difference("@monitored_api.api_checks.count", 1) do
      post check_monitored_api_url(@monitored_api)
    end

    assert_redirected_to monitored_api_url(@monitored_api)
    assert_equal "Prüfung abgeschlossen: Die API ist offline.", flash[:alert]
  end

  test "should get edit" do
    get edit_monitored_api_url(@monitored_api)
    assert_response :success
  end

  test "should update monitored_api" do
    patch monitored_api_url(@monitored_api), params: { monitored_api: { expected_status: @monitored_api.expected_status, name: @monitored_api.name, url: @monitored_api.url } }
    assert_redirected_to monitored_api_url(@monitored_api)
  end

  test "should destroy monitored_api" do
    assert_difference("MonitoredApi.count", -1) do
      delete monitored_api_url(@monitored_api)
    end

    assert_redirected_to monitored_apis_url
  end
end
