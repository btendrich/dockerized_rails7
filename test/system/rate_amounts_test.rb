require "application_system_test_case"

class RateAmountsTest < ApplicationSystemTestCase
  setup do
    @rate_amount = rate_amounts(:one)
  end

  test "visiting the index" do
    visit rate_amounts_url
    assert_selector "h1", text: "Rate amounts"
  end

  test "should create rate amount" do
    visit rate_amounts_url
    click_on "New rate amount"

    fill_in "Amount", with: @rate_amount.amount
    fill_in "Rate", with: @rate_amount.rate_id
    fill_in "Time period", with: @rate_amount.time_period_id
    click_on "Create Rate amount"

    assert_text "Rate amount was successfully created"
    click_on "Back"
  end

  test "should update Rate amount" do
    visit rate_amount_url(@rate_amount)
    click_on "Edit this rate amount", match: :first

    fill_in "Amount", with: @rate_amount.amount
    fill_in "Rate", with: @rate_amount.rate_id
    fill_in "Time period", with: @rate_amount.time_period_id
    click_on "Update Rate amount"

    assert_text "Rate amount was successfully updated"
    click_on "Back"
  end

  test "should destroy Rate amount" do
    visit rate_amount_url(@rate_amount)
    click_on "Destroy this rate amount", match: :first

    assert_text "Rate amount was successfully destroyed"
  end
end
