require "application_system_test_case"

class PayrollItemsTest < ApplicationSystemTestCase
  setup do
    @payroll_item = payroll_items(:one)
  end

  test "visiting the index" do
    visit payroll_items_url
    assert_selector "h1", text: "Payroll items"
  end

  test "should create payroll item" do
    visit payroll_items_url
    click_on "New payroll item"

    fill_in "Amount", with: @payroll_item.amount
    check "Correction" if @payroll_item.correction
    fill_in "Employee", with: @payroll_item.employee_id
    fill_in "Notes", with: @payroll_item.notes
    fill_in "Payroll", with: @payroll_item.payroll_id
    fill_in "Quantity", with: @payroll_item.quantity
    fill_in "Source hour", with: @payroll_item.source_hour_id
    fill_in "Source rate amount", with: @payroll_item.source_rate_amount_id
    fill_in "Source rate", with: @payroll_item.source_rate_id
    click_on "Create Payroll item"

    assert_text "Payroll item was successfully created"
    click_on "Back"
  end

  test "should update Payroll item" do
    visit payroll_item_url(@payroll_item)
    click_on "Edit this payroll item", match: :first

    fill_in "Amount", with: @payroll_item.amount
    check "Correction" if @payroll_item.correction
    fill_in "Employee", with: @payroll_item.employee_id
    fill_in "Notes", with: @payroll_item.notes
    fill_in "Payroll", with: @payroll_item.payroll_id
    fill_in "Quantity", with: @payroll_item.quantity
    fill_in "Source hour", with: @payroll_item.source_hour_id
    fill_in "Source rate amount", with: @payroll_item.source_rate_amount_id
    fill_in "Source rate", with: @payroll_item.source_rate_id
    click_on "Update Payroll item"

    assert_text "Payroll item was successfully updated"
    click_on "Back"
  end

  test "should destroy Payroll item" do
    visit payroll_item_url(@payroll_item)
    click_on "Destroy this payroll item", match: :first

    assert_text "Payroll item was successfully destroyed"
  end
end
