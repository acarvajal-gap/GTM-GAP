require 'test_helper'

class MettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metting = mettings(:one)
  end

  test "should get index" do
    get mettings_url
    assert_response :success
  end

  test "should get new" do
    get new_metting_url
    assert_response :success
  end

  test "should create metting" do
    assert_difference('Metting.count') do
      post mettings_url, params: { metting: { name: @metting.name } }
    end

    assert_redirected_to metting_url(Metting.last)
  end

  test "should show metting" do
    get metting_url(@metting)
    assert_response :success
  end

  test "should get edit" do
    get edit_metting_url(@metting)
    assert_response :success
  end

  test "should update metting" do
    patch metting_url(@metting), params: { metting: { name: @metting.name } }
    assert_redirected_to metting_url(@metting)
  end

  test "should destroy metting" do
    assert_difference('Metting.count', -1) do
      delete metting_url(@metting)
    end

    assert_redirected_to mettings_url
  end
end
