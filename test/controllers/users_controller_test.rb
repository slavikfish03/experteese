require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup page" do
    get signup_url

    assert_response :success
    assert_select "form[action*=?]", users_path
  end

  test "should create user with valid data" do
    assert_difference "User.count", 1 do
      post users_url, params: {
        user: {
          name: "Course User",
          email: "course@example.com",
          password: "222222",
          password_confirmation: "222222"
        }
      }
    end

    user = User.find_by!(email: "course@example.com")
    assert_redirected_to user_url(user, locale: :en)
    assert user.authenticate("222222")
  end

  test "anonymous user should be redirected from profile" do
    get user_url(users(:one))

    assert_redirected_to login_url(locale: :en)
  end

  test "signed in user should see personal rating statistics" do
    images(:one).update!(ave_value: 50)
    sign_in_as users(:one)

    get user_url(users(:one))

    assert_response :success
    assert_select "dd", text: "1"
    assert_select "h2", text: "Rating history"
    assert_select "h2", text: "Ratings within 25% of image average"
    assert_select "td", text: images(:one).name
    assert_select "td", text: themes(:one).name
  end

  test "signed in user cannot open another profile" do
    sign_in_as users(:one)

    get user_url(users(:two))

    assert_redirected_to user_url(users(:one), locale: :en)
  end

  test "should reject invalid email" do
    assert_no_difference "User.count" do
      post users_url, params: {
        user: {
          name: "Invalid Email User",
          email: "invalid-email",
          password: "222222",
          password_confirmation: "222222"
        }
      }
    end

    assert_response :unprocessable_entity
  end
end
