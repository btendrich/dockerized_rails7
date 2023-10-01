require "test_helper"

class RateAmountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate_amount = rate_amounts(:one)
  end

  test "should get index" do
    get rate_amounts_url
    assert_response :success
  end

  test "should get new" do
    get new_rate_amount_url
    assert_response :success
  end

  test "should create rate_amount" do
    assert_difference("RateAmount.count") do
      post rate_amounts_url, params: { rate_amount: { amount: @rate_amount.amount, rate_id: @rate_amount.rate_id, time_period_id: @rate_amount.time_period_id } }
    end

    assert_redirected_to rate_amount_url(RateAmount.last)
  end

  test "should show rate_amount" do
    get rate_amount_url(@rate_amount)
    assert_response :success
  end

  test "should get edit" do
    get edit_rate_amount_url(@rate_amount)
    assert_response :success
  end

  test "should update rate_amount" do
    patch rate_amount_url(@rate_amount), params: { rate_amount: { amount: @rate_amount.amount, rate_id: @rate_amount.rate_id, time_period_id: @rate_amount.time_period_id } }
    assert_redirected_to rate_amount_url(@rate_amount)
  end

  test "should destroy rate_amount" do
    assert_difference("RateAmount.count", -1) do
      delete rate_amount_url(@rate_amount)
    end

    assert_redirected_to rate_amounts_url
  end
end
