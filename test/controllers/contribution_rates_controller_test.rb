require "test_helper"

class ContributionRatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contribution_rate = contribution_rates(:one)
  end

  test "should get index" do
    get contribution_rates_url
    assert_response :success
  end

  test "should get new" do
    get new_contribution_rate_url
    assert_response :success
  end

  test "should create contribution_rate" do
    assert_difference("ContributionRate.count") do
      post contribution_rates_url, params: { contribution_rate: { employee_classification_id: @contribution_rate.employee_classification_id, name: @contribution_rate.name, rate: @contribution_rate.rate, rate_classification_id: @contribution_rate.rate_classification_id, time_period_id: @contribution_rate.time_period_id } }
    end

    assert_redirected_to contribution_rate_url(ContributionRate.last)
  end

  test "should show contribution_rate" do
    get contribution_rate_url(@contribution_rate)
    assert_response :success
  end

  test "should get edit" do
    get edit_contribution_rate_url(@contribution_rate)
    assert_response :success
  end

  test "should update contribution_rate" do
    patch contribution_rate_url(@contribution_rate), params: { contribution_rate: { employee_classification_id: @contribution_rate.employee_classification_id, name: @contribution_rate.name, rate: @contribution_rate.rate, rate_classification_id: @contribution_rate.rate_classification_id, time_period_id: @contribution_rate.time_period_id } }
    assert_redirected_to contribution_rate_url(@contribution_rate)
  end

  test "should destroy contribution_rate" do
    assert_difference("ContributionRate.count", -1) do
      delete contribution_rate_url(@contribution_rate)
    end

    assert_redirected_to contribution_rates_url
  end
end
