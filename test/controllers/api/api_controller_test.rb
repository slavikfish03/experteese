require "test_helper"

module Api
  class ApiControllerTest < ActionDispatch::IntegrationTest
    test "next_image returns the next image as json" do
      theme, first_image, second_image = create_theme_with_images

      get api_next_image_url, params: { theme_id: theme.id, index: 0 }

      assert_response :success
      payload = response.parsed_body
      assert_equal second_image.id, payload["image_id"]
      assert_equal second_image.name, payload["name"]
      assert_equal 1, payload["index"]
      assert_equal 2, payload["images_arr_size"]
      assert_match %r{\A/assets/renoir_garden-[a-f0-9]+\.jpg\z}, payload["image_url"]
      assert_not_equal first_image.id, payload["image_id"]
    end

    test "next_image wraps from last image to first image" do
      theme, first_image = create_theme_with_images

      get api_next_image_url, params: { theme_id: theme.id, index: 1 }

      assert_response :success
      payload = response.parsed_body
      assert_equal first_image.id, payload["image_id"]
      assert_equal 0, payload["index"]
    end

    test "prev_image wraps from first image to last image" do
      theme, = create_theme_with_images
      last_image = Image.theme_images(theme.id).order(:id).last

      get api_prev_image_url, params: { theme_id: theme.id, index: 0 }

      assert_response :success
      payload = response.parsed_body
      assert_equal last_image.id, payload["image_id"]
      assert_equal 1, payload["index"]
    end

    test "image endpoint returns not found for missing theme" do
      get api_next_image_url, params: { theme_id: 0, index: 0 }

      assert_response :not_found
      assert_equal "Theme not found", response.parsed_body["error"]
    end

    test "image endpoint includes signed in user's rating state" do
      sign_in_as users(:one)

      get api_next_image_url, params: { theme_id: themes(:one).id, index: 0 }

      assert_response :success
      payload = response.parsed_body
      user_value = users(:one).values.find_by!(image_id: payload["image_id"])

      assert_equal true, payload["user_valued"]
      assert_equal user_value.value, payload["value"]
    end

    private

    def create_theme_with_images
      theme = Theme.create!(name: "API Navigation Theme")
      first_image = Image.create!(name: "API First Image", file: "renoir_bouquet.jpg", theme: theme, ave_value: 10)
      second_image = Image.create!(name: "API Second Image", file: "renoir_garden.jpg", theme: theme, ave_value: 20)

      [ theme, first_image, second_image ]
    end
  end
end
