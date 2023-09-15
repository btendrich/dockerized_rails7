require "test_helper"

class TimePeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_period = time_periods(:one)
  end

  test "should get index" do
    get time_periods_url
    assert_response :success
  end

  test "should get new" do
    get new_time_period_url
    assert_response :success
  end

  test "should create time_period" do
    assert_difference("TimePeriod.count") do
      post time_periods_url, params: { time_period: { begins: @time_period.begins, description: @time_period.description, ends: @time_period.ends, name: @time_period.name } }
    end

    assert_redirected_to time_period_url(TimePeriod.last)
  end

  test "should show time_period" do
    get time_period_url(@time_period)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_period_url(@time_period)
    assert_response :success
  end

  test "should update time_period" do
    patch time_period_url(@time_period), params: { time_period: { begins: @time_period.begins, description: @time_period.description, ends: @time_period.ends, name: @time_period.name } }
    assert_redirected_to time_period_url(@time_period)
  end

  test "should destroy time_period" do
    assert_difference("TimePeriod.count", -1) do
      delete time_period_url(@time_period)
    end

    assert_redirected_to time_periods_url
  end
end
