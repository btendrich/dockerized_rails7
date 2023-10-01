require "application_system_test_case"

class ContributionRatesTest < ApplicationSystemTestCase
  setup do
    @contribution_rate = contribution_rates(:one)
  end

  test "visiting the index" do
    visit contribution_rates_url
    assert_selector "h1", text: "Contribution rates"
  end

  test "should create contribution rate" do
    visit contribution_rates_url
    click_on "New contribution rate"

    fill_in "Employee classification", with: @contribution_rate.employee_classification_id
    fill_in "Name", with: @contribution_rate.name
    fill_in "Rate", with: @contribution_rate.rate
    fill_in "Rate classification", with: @contribution_rate.rate_classification_id
    fill_in "Time period", with: @contribution_rate.time_period_id
    click_on "Create Contribution rate"

    assert_text "Contribution rate was successfully created"
    click_on "Back"
  end

  test "should update Contribution rate" do
    visit contribution_rate_url(@contribution_rate)
    click_on "Edit this contribution rate", match: :first

    fill_in "Employee classification", with: @contribution_rate.employee_classification_id
    fill_in "Name", with: @contribution_rate.name
    fill_in "Rate", with: @contribution_rate.rate
    fill_in "Rate classification", with: @contribution_rate.rate_classification_id
    fill_in "Time period", with: @contribution_rate.time_period_id
    click_on "Update Contribution rate"

    assert_text "Contribution rate was successfully updated"
    click_on "Back"
  end

  test "should destroy Contribution rate" do
    visit contribution_rate_url(@contribution_rate)
    click_on "Destroy this contribution rate", match: :first

    assert_text "Contribution rate was successfully destroyed"
  end
end
