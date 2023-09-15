require "application_system_test_case"

class TimePeriodsTest < ApplicationSystemTestCase
  setup do
    @time_period = time_periods(:one)
  end

  test "visiting the index" do
    visit time_periods_url
    assert_selector "h1", text: "Time periods"
  end

  test "should create time period" do
    visit time_periods_url
    click_on "New time period"

    fill_in "Begins", with: @time_period.begins
    fill_in "Description", with: @time_period.description
    fill_in "Ends", with: @time_period.ends
    fill_in "Name", with: @time_period.name
    click_on "Create Time period"

    assert_text "Time period was successfully created"
    click_on "Back"
  end

  test "should update Time period" do
    visit time_period_url(@time_period)
    click_on "Edit this time period", match: :first

    fill_in "Begins", with: @time_period.begins
    fill_in "Description", with: @time_period.description
    fill_in "Ends", with: @time_period.ends
    fill_in "Name", with: @time_period.name
    click_on "Update Time period"

    assert_text "Time period was successfully updated"
    click_on "Back"
  end

  test "should destroy Time period" do
    visit time_period_url(@time_period)
    click_on "Destroy this time period", match: :first

    assert_text "Time period was successfully destroyed"
  end
end
