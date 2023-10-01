require "application_system_test_case"

class HoursTest < ApplicationSystemTestCase
  setup do
    @hour = hours(:one)
  end

  test "visiting the index" do
    visit hours_url
    assert_selector "h1", text: "Hours"
  end

  test "should create hour" do
    visit hours_url
    click_on "New hour"

    check "Correction" if @hour.correction
    fill_in "Date", with: @hour.date
    fill_in "Employee", with: @hour.employee_id
    fill_in "Hour", with: @hour.hour
    fill_in "Notes", with: @hour.notes
    fill_in "Quantity", with: @hour.quantity
    fill_in "Rate", with: @hour.rate_id
    fill_in "When", with: @hour.when
    click_on "Create Hour"

    assert_text "Hour was successfully created"
    click_on "Back"
  end

  test "should update Hour" do
    visit hour_url(@hour)
    click_on "Edit this hour", match: :first

    check "Correction" if @hour.correction
    fill_in "Date", with: @hour.date
    fill_in "Employee", with: @hour.employee_id
    fill_in "Hour", with: @hour.hour
    fill_in "Notes", with: @hour.notes
    fill_in "Quantity", with: @hour.quantity
    fill_in "Rate", with: @hour.rate_id
    fill_in "When", with: @hour.when
    click_on "Update Hour"

    assert_text "Hour was successfully updated"
    click_on "Back"
  end

  test "should destroy Hour" do
    visit hour_url(@hour)
    click_on "Destroy this hour", match: :first

    assert_text "Hour was successfully destroyed"
  end
end
