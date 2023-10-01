require "test_helper"

class PaychecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paycheck = paychecks(:one)
  end

  test "should get index" do
    get paychecks_url
    assert_response :success
  end

  test "should get new" do
    get new_paycheck_url
    assert_response :success
  end

  test "should create paycheck" do
    assert_difference("Paycheck.count") do
      post paychecks_url, params: { paycheck: { employee_id: @paycheck.employee_id, gross: @paycheck.gross, notes: @paycheck.notes, reconciled: @paycheck.reconciled, week_ending: @paycheck.week_ending } }
    end

    assert_redirected_to paycheck_url(Paycheck.last)
  end

  test "should show paycheck" do
    get paycheck_url(@paycheck)
    assert_response :success
  end

  test "should get edit" do
    get edit_paycheck_url(@paycheck)
    assert_response :success
  end

  test "should update paycheck" do
    patch paycheck_url(@paycheck), params: { paycheck: { employee_id: @paycheck.employee_id, gross: @paycheck.gross, notes: @paycheck.notes, reconciled: @paycheck.reconciled, week_ending: @paycheck.week_ending } }
    assert_redirected_to paycheck_url(@paycheck)
  end

  test "should destroy paycheck" do
    assert_difference("Paycheck.count", -1) do
      delete paycheck_url(@paycheck)
    end

    assert_redirected_to paychecks_url
  end
end
