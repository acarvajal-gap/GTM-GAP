require "application_system_test_case"

class MettingsTest < ApplicationSystemTestCase
  setup do
    @metting = mettings(:one)
  end

  test "visiting the index" do
    visit mettings_url
    assert_selector "h1", text: "Mettings"
  end

  test "creating a Metting" do
    visit mettings_url
    click_on "New Metting"

    fill_in "Name", with: @metting.name
    click_on "Create Metting"

    assert_text "Metting was successfully created"
    click_on "Back"
  end

  test "updating a Metting" do
    visit mettings_url
    click_on "Edit", match: :first

    fill_in "Name", with: @metting.name
    click_on "Update Metting"

    assert_text "Metting was successfully updated"
    click_on "Back"
  end

  test "destroying a Metting" do
    visit mettings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Metting was successfully destroyed"
  end
end
