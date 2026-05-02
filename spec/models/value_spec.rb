require "rails_helper"

RSpec.describe Value do
  it "belongs to a user and image" do
    expect(values(:one).user).to eq(users(:one))
    expect(values(:one).image).to eq(images(:one))
  end

  it "requires value in the 5..100 range" do
    values(:one).value = 4
    expect(values(:one)).not_to be_valid

    values(:one).value = 101
    expect(values(:one)).not_to be_valid
  end

  it "rejects duplicate user rating for the same image" do
    rating = described_class.new(user: users(:one), image: images(:one), value: 80)

    expect(rating).not_to be_valid
  end

  it "returns ratings within twenty five percent of image average" do
    images(:one).update!(ave_value: 80)
    images(:two).update!(ave_value: 100)
    values(:one).update!(value: 64)
    values(:two).update!(value: 70)

    ratings = described_class.within_twenty_five_percent_of_image_average

    expect(ratings).to include(values(:one))
    expect(ratings).not_to include(values(:two))
  end

  it "refreshes image average after create" do
    rating = described_class.create!(user: users(:one), image: images(:two), value: 85)

    expect(rating.image.reload.ave_value).to eq(80)
  end
end
