require "test_helper"

class SakeLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sake_log = sake_logs(:one)
  end

  test "should get index" do
    get sake_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_sake_log_url
    assert_response :success
  end

  test "should create sake_log" do
    assert_difference("SakeLog.count") do
      post sake_logs_url, params: { sake_log: { memo: @sake_log.memo, name: @sake_log.name, taste: @sake_log.taste } }
    end

    assert_redirected_to sake_log_url(SakeLog.last)
  end

  test "should show sake_log" do
    get sake_log_url(@sake_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_sake_log_url(@sake_log)
    assert_response :success
  end

  test "should update sake_log" do
    patch sake_log_url(@sake_log), params: { sake_log: { memo: @sake_log.memo, name: @sake_log.name, taste: @sake_log.taste } }
    assert_redirected_to sake_log_url(@sake_log)
  end

  test "should destroy sake_log" do
    assert_difference("SakeLog.count", -1) do
      delete sake_log_url(@sake_log)
    end

    assert_redirected_to sake_logs_url
  end
end
