require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference("Employee.count") do
      post employees_url, params: { employee: { address1: @employee.address1, address2: @employee.address2, affiliation_card_number: @employee.affiliation_card_number, affiliation_organization: @employee.affiliation_organization, city: @employee.city, classification: @employee.classification, dob: @employee.dob, first_name: @employee.first_name, last_name: @employee.last_name, notes: @employee.notes, payroll_active: @employee.payroll_active, payroll_code: @employee.payroll_code, phone: @employee.phone, state: @employee.state, zip: @employee.zip } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { address1: @employee.address1, address2: @employee.address2, affiliation_card_number: @employee.affiliation_card_number, affiliation_organization: @employee.affiliation_organization, city: @employee.city, classification: @employee.classification, dob: @employee.dob, first_name: @employee.first_name, last_name: @employee.last_name, notes: @employee.notes, payroll_active: @employee.payroll_active, payroll_code: @employee.payroll_code, phone: @employee.phone, state: @employee.state, zip: @employee.zip } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference("Employee.count", -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end
