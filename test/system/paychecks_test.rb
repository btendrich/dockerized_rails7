require "application_system_test_case"

class PaychecksTest < ApplicationSystemTestCase
  setup do
    @paycheck = paychecks(:one)
  end

  test "visiting the index" do
    visit paychecks_url
    assert_selector "h1", text: "Paychecks"
  end

  test "should create paycheck" do
    visit paychecks_url
    click_on "New paycheck"

    fill_in "Employee", with: @paycheck.employee_id
    fill_in "Gross", with: @paycheck.gross
    fill_in "Notes", with: @paycheck.notes
    check "Reconciled" if @paycheck.reconciled
    fill_in "Week ending", with: @paycheck.week_ending
    click_on "Create Paycheck"

    assert_text "Paycheck was successfully created"
    click_on "Back"
  end

  test "should update Paycheck" do
    visit paycheck_url(@paycheck)
    click_on "Edit this paycheck", match: :first

    fill_in "Employee", with: @paycheck.employee_id
    fill_in "Gross", with: @paycheck.gross
    fill_in "Notes", with: @paycheck.notes
    check "Reconciled" if @paycheck.reconciled
    fill_in "Week ending", with: @paycheck.week_ending
    click_on "Update Paycheck"

    assert_text "Paycheck was successfully updated"
    click_on "Back"
  end

  test "should destroy Paycheck" do
    visit paycheck_url(@paycheck)
    click_on "Destroy this paycheck", match: :first

    assert_text "Paycheck was successfully destroyed"
  end
end
