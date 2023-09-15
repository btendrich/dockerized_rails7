require "test_helper"

class RateClassificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate_classification = rate_classifications(:one)
  end

  test "should get index" do
    get rate_classifications_url
    assert_response :success
  end

  test "should get new" do
    get new_rate_classification_url
    assert_response :success
  end

  test "should create rate_classification" do
    assert_difference("RateClassification.count") do
      post rate_classifications_url, params: { rate_classification: { name: @rate_classification.name } }
    end

    assert_redirected_to rate_classification_url(RateClassification.last)
  end

  test "should show rate_classification" do
    get rate_classification_url(@rate_classification)
    assert_response :success
  end

  test "should get edit" do
    get edit_rate_classification_url(@rate_classification)
    assert_response :success
  end

  test "should update rate_classification" do
    patch rate_classification_url(@rate_classification), params: { rate_classification: { name: @rate_classification.name } }
    assert_redirected_to rate_classification_url(@rate_classification)
  end

  test "should destroy rate_classification" do
    assert_difference("RateClassification.count", -1) do
      delete rate_classification_url(@rate_classification)
    end

    assert_redirected_to rate_classifications_url
  end
end
