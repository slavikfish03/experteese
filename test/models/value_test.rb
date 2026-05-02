require "test_helper"

class ValueTest < ActiveSupport::TestCase
  test "scope returns ratings within twenty five percent of image average" do
    images(:one).update!(ave_value: 80)
    images(:two).update!(ave_value: 100)
    values(:one).update!(value: 64)
    values(:two).update!(value: 70)

    ratings = Value.within_twenty_five_percent_of_image_average

    assert_includes ratings, values(:one)
    assert_not_includes ratings, values(:two)
  end

  test "creating a value refreshes image average" do
    image = images(:two)

    Value.create!(user: users(:one), image: image, value: 85)

    assert_equal 80, image.reload.ave_value
  end
end
