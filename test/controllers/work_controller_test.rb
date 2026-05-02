require "test_helper"

class WorkControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get work_url

    assert_response :success
    assert_select "select[name=?]", "theme_id"
    assert_select "img[alt=?]", images(:one).name
    assert_select "input[name=?][min=?][max=?]", "value", "5", "100"
    assert_select "input[type=?][value=?][disabled]", "submit", "Submit rating"
  end

  test "should select requested theme" do
    get work_url(theme_id: themes(:two).id)

    assert_response :success
    assert_select "h2", images(:two).name
    assert_select "img[alt=?]", images(:two).name
  end
end
