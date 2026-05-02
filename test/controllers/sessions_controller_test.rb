require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login page" do
    get login_url

    assert_response :success
    assert_select "form[action*=?]", login_path
  end

  test "should sign in with valid credentials and sign out" do
    sign_in_as users(:one)

    assert_redirected_to work_url(locale: :en)
    assert_not_empty cookies[:remember_token]

    delete logout_url

    assert_redirected_to root_url(locale: :en)
    assert_empty cookies[:remember_token].to_s
  end

  test "should reject invalid credentials" do
    post login_url, params: {
      session: {
        email: users(:one).email,
        password: "wrong-password"
      }
    }

    assert_response :unprocessable_entity
    assert_empty cookies[:remember_token].to_s
  end
end
