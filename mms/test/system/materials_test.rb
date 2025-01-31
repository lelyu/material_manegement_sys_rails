require "application_system_test_case"

class MaterialsTest < ApplicationSystemTestCase
  setup do
    @material = materials(:one)
  end

  test "visiting the index" do
    visit materials_url
    assert_selector "h1", text: "Materials"
  end

  test "should create material" do
    visit materials_url
    click_on "New material"

    fill_in "Check in", with: @material.check_in
    fill_in "Check out", with: @material.check_out
    fill_in "Instructor", with: @material.instructor
    fill_in "Location", with: @material.location
    fill_in "Name", with: @material.name
    fill_in "Quantity", with: @material.quantity
    click_on "Create Material"

    assert_text "Material was successfully created"
    click_on "Back"
  end

  test "should update Material" do
    visit material_url(@material)
    click_on "Edit this material", match: :first

    fill_in "Check in", with: @material.check_in
    fill_in "Check out", with: @material.check_out
    fill_in "Instructor", with: @material.instructor
    fill_in "Location", with: @material.location
    fill_in "Name", with: @material.name
    fill_in "Quantity", with: @material.quantity
    click_on "Update Material"

    assert_text "Material was successfully updated"
    click_on "Back"
  end

  test "should destroy Material" do
    visit material_url(@material)
    click_on "Destroy this material", match: :first

    assert_text "Material was successfully destroyed"
  end
end
