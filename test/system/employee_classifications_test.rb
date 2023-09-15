require "application_system_test_case"

class EmployeeClassificationsTest < ApplicationSystemTestCase
  setup do
    @employee_classification = employee_classifications(:one)
  end

  test "visiting the index" do
    visit employee_classifications_url
    assert_selector "h1", text: "Employee classifications"
  end

  test "should create employee classification" do
    visit employee_classifications_url
    click_on "New employee classification"

    fill_in "Name", with: @employee_classification.name
    click_on "Create Employee classification"

    assert_text "Employee classification was successfully created"
    click_on "Back"
  end

  test "should update Employee classification" do
    visit employee_classification_url(@employee_classification)
    click_on "Edit this employee classification", match: :first

    fill_in "Name", with: @employee_classification.name
    click_on "Update Employee classification"

    assert_text "Employee classification was successfully updated"
    click_on "Back"
  end

  test "should destroy Employee classification" do
    visit employee_classification_url(@employee_classification)
    click_on "Destroy this employee classification", match: :first

    assert_text "Employee classification was successfully destroyed"
  end
end
