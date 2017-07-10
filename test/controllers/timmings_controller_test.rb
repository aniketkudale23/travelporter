require 'test_helper'

class TimmingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timming = timmings(:one)
  end

  test "should get index" do
    get timmings_url
    assert_response :success
  end

  test "should get new" do
    get new_timming_url
    assert_response :success
  end

  test "should create timming" do
    assert_difference('Timming.count') do
      post timmings_url, params: { timming: { bus_type: @timming.bus_type, in: @timming.in, provider: @timming.provider } }
    end

    assert_redirected_to timming_url(Timming.last)
  end

  test "should show timming" do
    get timming_url(@timming)
    assert_response :success
  end

  test "should get edit" do
    get edit_timming_url(@timming)
    assert_response :success
  end

  test "should update timming" do
    patch timming_url(@timming), params: { timming: { bus_type: @timming.bus_type, in: @timming.in, provider: @timming.provider } }
    assert_redirected_to timming_url(@timming)
  end

  test "should destroy timming" do
    assert_difference('Timming.count', -1) do
      delete timming_url(@timming)
    end

    assert_redirected_to timmings_url
  end
end
