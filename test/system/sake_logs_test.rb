require "application_system_test_case"

class SakeLogsTest < ApplicationSystemTestCase
  setup do
    @sake_log = sake_logs(:one)
  end

  test "visiting the index" do
    visit sake_logs_url
    assert_selector "h1", text: "Sake logs"
  end

  test "should create sake log" do
    visit sake_logs_url
    click_on "New sake log"

    fill_in "Memo", with: @sake_log.memo
    fill_in "Name", with: @sake_log.name
    fill_in "Taste", with: @sake_log.taste
    click_on "Create Sake log"

    assert_text "Sake log was successfully created"
    click_on "Back"
  end

  test "should update Sake log" do
    visit sake_log_url(@sake_log)
    click_on "Edit this sake log", match: :first

    fill_in "Memo", with: @sake_log.memo
    fill_in "Name", with: @sake_log.name
    fill_in "Taste", with: @sake_log.taste
    click_on "Update Sake log"

    assert_text "Sake log was successfully updated"
    click_on "Back"
  end

  test "should destroy Sake log" do
    visit sake_log_url(@sake_log)
    click_on "Destroy this sake log", match: :first

    assert_text "Sake log was successfully destroyed"
  end
end
