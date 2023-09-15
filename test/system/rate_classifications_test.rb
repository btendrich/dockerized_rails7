require "application_system_test_case"

class RateClassificationsTest < ApplicationSystemTestCase
  setup do
    @rate_classification = rate_classifications(:one)
  end

  test "visiting the index" do
    visit rate_classifications_url
    assert_selector "h1", text: "Rate classifications"
  end

  test "should create rate classification" do
    visit rate_classifications_url
    click_on "New rate classification"

    fill_in "Name", with: @rate_classification.name
    click_on "Create Rate classification"

    assert_text "Rate classification was successfully created"
    click_on "Back"
  end

  test "should update Rate classification" do
    visit rate_classification_url(@rate_classification)
    click_on "Edit this rate classification", match: :first

    fill_in "Name", with: @rate_classification.name
    click_on "Update Rate classification"

    assert_text "Rate classification was successfully updated"
    click_on "Back"
  end

  test "should destroy Rate classification" do
    visit rate_classification_url(@rate_classification)
    click_on "Destroy this rate classification", match: :first

    assert_text "Rate classification was successfully destroyed"
  end
end
