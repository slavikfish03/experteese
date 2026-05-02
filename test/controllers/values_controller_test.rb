require "test_helper"

class ValuesControllerTest < ActionDispatch::IntegrationTest
  test "anonymous user cannot submit rating" do
    assert_no_difference "Value.count" do
      post values_url, params: { image_id: images(:two).id, value: 85 }
    end

    assert_redirected_to login_url(locale: :en)
  end

  test "signed in user can submit rating" do
    image = images(:two)
    sign_in_as users(:one)

    assert_difference "Value.count", 1 do
      post values_url, params: { image_id: image.id, value: 85 }
    end

    assert_redirected_to work_url(locale: :en, theme_id: image.theme_id)
    assert_equal 80, image.reload.ave_value
  end

  test "signed in user cannot submit duplicate rating" do
    sign_in_as users(:one)

    assert_no_difference "Value.count" do
      post values_url, params: { image_id: images(:one).id, value: 90 }
    end

    assert_redirected_to work_url(locale: :en, theme_id: images(:one).theme_id)
  end
end
