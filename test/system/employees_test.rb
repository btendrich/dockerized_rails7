require "application_system_test_case"

class EmployeesTest < ApplicationSystemTestCase
  setup do
    @employee = employees(:one)
  end

  test "visiting the index" do
    visit employees_url
    assert_selector "h1", text: "Employees"
  end

  test "should create employee" do
    visit employees_url
    click_on "New employee"

    fill_in "Address1", with: @employee.address1
    fill_in "Address2", with: @employee.address2
    fill_in "Affiliation card number", with: @employee.affiliation_card_number
    fill_in "Affiliation organization", with: @employee.affiliation_organization
    fill_in "City", with: @employee.city
    fill_in "Classification", with: @employee.classification
    fill_in "Dob", with: @employee.dob
    fill_in "First name", with: @employee.first_name
    fill_in "Last name", with: @employee.last_name
    fill_in "Notes", with: @employee.notes
    check "Payroll active" if @employee.payroll_active
    fill_in "Payroll code", with: @employee.payroll_code
    fill_in "Phone", with: @employee.phone
    fill_in "State", with: @employee.state
    fill_in "Zip", with: @employee.zip
    click_on "Create Employee"

    assert_text "Employee was successfully created"
    click_on "Back"
  end

  test "should update Employee" do
    visit employee_url(@employee)
    click_on "Edit this employee", match: :first

    fill_in "Address1", with: @employee.address1
    fill_in "Address2", with: @employee.address2
    fill_in "Affiliation card number", with: @employee.affiliation_card_number
    fill_in "Affiliation organization", with: @employee.affiliation_organization
    fill_in "City", with: @employee.city
    fill_in "Classification", with: @employee.classification
    fill_in "Dob", with: @employee.dob
    fill_in "First name", with: @employee.first_name
    fill_in "Last name", with: @employee.last_name
    fill_in "Notes", with: @employee.notes
    check "Payroll active" if @employee.payroll_active
    fill_in "Payroll code", with: @employee.payroll_code
    fill_in "Phone", with: @employee.phone
    fill_in "State", with: @employee.state
    fill_in "Zip", with: @employee.zip
    click_on "Update Employee"

    assert_text "Employee was successfully updated"
    click_on "Back"
  end

  test "should destroy Employee" do
    visit employee_url(@employee)
    click_on "Destroy this employee", match: :first

    assert_text "Employee was successfully destroyed"
  end
end
