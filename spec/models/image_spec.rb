require "rails_helper"

RSpec.describe Image do
  it "belongs to a theme" do
    expect(images(:one).theme).to eq(themes(:one))
  end

  it "requires a unique file" do
    image = described_class.new(
      name: "Duplicate File Image",
      file: images(:one).file,
      theme: themes(:one),
      ave_value: 0
    )

    expect(image).not_to be_valid
  end

  it "requires a non-negative average value" do
    images(:one).ave_value = -1

    expect(images(:one)).not_to be_valid
  end

  it "returns images for a theme" do
    expect(described_class.theme_images(themes(:one).id)).to include(images(:one))
  end

  it "updates an image average value" do
    described_class.update_ave_value(images(:one).id, 42)

    expect(images(:one).reload.ave_value).to eq(42)
  end
end
