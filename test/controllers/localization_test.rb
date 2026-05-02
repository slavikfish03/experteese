require "test_helper"

class LocalizationTest < ActionDispatch::IntegrationTest
  test "default locale renders english navigation" do
    get root_url

    assert_response :success
    assert_select "a", text: "Home"
    assert_select ".locale-link.active", text: "EN"
  end

  test "locale parameter renders russian and is preserved across links" do
    get root_url(locale: :ru)

    assert_response :success
    assert_select "a", text: "Главная"
    assert_select ".locale-link.active", text: "RU"
    assert_select "a[href*=?]", "locale=ru", minimum: 1
  end

  test "selected locale is preserved in session" do
    get root_url(locale: :ru)
    get help_url

    assert_response :success
    assert_select "h1", text: "Куда можно обратиться, если изображения непонятны?"
  end

  test "can switch back to english" do
    get root_url(locale: :ru)
    get root_url(locale: :en)

    assert_response :success
    assert_select "a", text: "Home"
    assert_select ".locale-link.active", text: "EN"
  end
end
