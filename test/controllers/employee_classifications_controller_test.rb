require "test_helper"

class EmployeeClassificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_classification = employee_classifications(:one)
  end

  test "should get index" do
    get employee_classifications_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_classification_url
    assert_response :success
  end

  test "should create employee_classification" do
    assert_difference("EmployeeClassification.count") do
      post employee_classifications_url, params: { employee_classification: { name: @employee_classification.name } }
    end

    assert_redirected_to employee_classification_url(EmployeeClassification.last)
  end

  test "should show employee_classification" do
    get employee_classification_url(@employee_classification)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_classification_url(@employee_classification)
    assert_response :success
  end

  test "should update employee_classification" do
    patch employee_classification_url(@employee_classification), params: { employee_classification: { name: @employee_classification.name } }
    assert_redirected_to employee_classification_url(@employee_classification)
  end

  test "should destroy employee_classification" do
    assert_difference("EmployeeClassification.count", -1) do
      delete employee_classification_url(@employee_classification)
    end

    assert_redirected_to employee_classifications_url
  end
end
