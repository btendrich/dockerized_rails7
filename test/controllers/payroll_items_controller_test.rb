require "test_helper"

class PayrollItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payroll_item = payroll_items(:one)
  end

  test "should get index" do
    get payroll_items_url
    assert_response :success
  end

  test "should get new" do
    get new_payroll_item_url
    assert_response :success
  end

  test "should create payroll_item" do
    assert_difference("PayrollItem.count") do
      post payroll_items_url, params: { payroll_item: { amount: @payroll_item.amount, correction: @payroll_item.correction, employee_id: @payroll_item.employee_id, notes: @payroll_item.notes, payroll_id: @payroll_item.payroll_id, quantity: @payroll_item.quantity, source_hour_id: @payroll_item.source_hour_id, source_rate_amount_id: @payroll_item.source_rate_amount_id, source_rate_id: @payroll_item.source_rate_id } }
    end

    assert_redirected_to payroll_item_url(PayrollItem.last)
  end

  test "should show payroll_item" do
    get payroll_item_url(@payroll_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_payroll_item_url(@payroll_item)
    assert_response :success
  end

  test "should update payroll_item" do
    patch payroll_item_url(@payroll_item), params: { payroll_item: { amount: @payroll_item.amount, correction: @payroll_item.correction, employee_id: @payroll_item.employee_id, notes: @payroll_item.notes, payroll_id: @payroll_item.payroll_id, quantity: @payroll_item.quantity, source_hour_id: @payroll_item.source_hour_id, source_rate_amount_id: @payroll_item.source_rate_amount_id, source_rate_id: @payroll_item.source_rate_id } }
    assert_redirected_to payroll_item_url(@payroll_item)
  end

  test "should destroy payroll_item" do
    assert_difference("PayrollItem.count", -1) do
      delete payroll_item_url(@payroll_item)
    end

    assert_redirected_to payroll_items_url
  end
end
